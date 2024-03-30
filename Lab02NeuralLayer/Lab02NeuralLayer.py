from math import ceil
import os
import re
from PIL import Image

def getFiles(dir: str, pattern: str) -> list[str]:
    '''Формирования списка путей к файлам'''
    return [f'{dir}\{f}' for f in os.listdir(dir) if os.path.isfile(f'{dir}\{f}') and re.fullmatch(pattern, f)]

def printImg(img: Image.Image) -> None:
    '''Вывод значений пикселей изображения в консоль'''
    for j in range(img.height):
        imgString = ""
        for i in range(img.width):
            imgString += f'{img.getpixel((i, j))} '
        print(imgString)

def getTrainingSet(imageFiles: list[str]) -> list[tuple[list[int], list[int], str]]:
    '''Формирование сета для обучения'''
    images = list(map(lambda x: Image.open(x), imageFiles))
    if max(img.width for img in images) != min(img.width for img in images) or max(img.height for img in images) != min(img.height for img in images):
        raise ValueError("Invalid arguments for training set formation.")
    names = []
    for imageFile in imageFiles:
        name = imageFile.split("\\")[-1].split("_")[0]
        if name in names:
            continue
        names.append(name)
    trainingSet = []
    for i in range(len(images)):
        img = images[i]
        imgPattern = getImagePattern(img)
        name = imageFiles[i].split("\\")[-1].split("_")[0]
        resultPattern = list(map(lambda j: 1 if names[j] == name else 0, range(len(names))))
        trainingSet.append((imgPattern, resultPattern, name))
    return trainingSet

def getImagePattern(img: Image.Image) -> list[int]:
        '''Формирование образа изображения'''    
        imgPattern = []
        for j in range(img.height):
            for i in range(img.width):
                imgPattern.append(img.getpixel((i, j)))
        return imgPattern

def getWeightMatrix(trainingSet: list[tuple[list[int], list[int]], str], activationThreshhold: float = 0, maxCycles: int = 0) -> tuple[list[list[int]], float]:
    '''Формирование матрицы весов нейронов'''
    if max(len(p[0]) for p in trainingSet) != min(len(p[0]) for p in trainingSet) or max(len(p[1]) for p in trainingSet) != min(len(p[1]) for p in trainingSet) or maxCycles < 0:
        raise ValueError("Invalid arguments for weight matrix formation.")
    print(f'Формирование матрицы весов' + '.' if maxCycles == 0 else f' с ограничением в {maxCycles} циклов.')
    names = []
    for pattern in trainingSet:
        name = pattern[2]
        if name in names:
            continue
        names.append(name)
    patternVariantsCount = len(names)
    patternCount = len(trainingSet)
    patternLength = len(trainingSet[0][0])
    weightMatrix = [[0 for i in range(patternLength)] for j in range(patternVariantsCount)]
    maxCycles = maxCycles if maxCycles > 0 else -1
    currentCycle = 0
    reportPercent = 0
    while maxCycles < 0 or currentCycle < maxCycles:
        weightsCorrected = False
        for i in range(patternCount):
            pattern = trainingSet[i]
            for j in range(patternVariantsCount):
                neuronWeights = weightMatrix[j]
                sj = sum(list(map(lambda k: pattern[0][k] * neuronWeights[k], range(patternLength))))
                yj = 0 if sj < activationThreshhold else 1
                tj = pattern[1][j]
                dy = 0 if yj == tj else (1 if yj < tj else -1)
                for k in range(patternLength):
                    dx = pattern[0][k] * dy
                    neuronWeights[k] += dx
                    weightsCorrected = weightsCorrected or abs(dx) > 0.5
        if not weightsCorrected:
            break
        currentCycle += 1
        if maxCycles > 0:
            percentDone = ceil(100 * currentCycle / maxCycles)
            if percentDone >= reportPercent:
                print(f'{reportPercent}% максимального количества циклов завершено.')
                reportPercent += 10
    print(f'Завершено за {currentCycle} циклов.')
    return (weightMatrix, activationThreshhold)

def recognizePattern(pattern: list[int], weightMatrix: tuple[list[list[int]], float], shiftLimit: int = 0) -> tuple[list[int], int]:
    '''Распознавание образа'''
    if max(len(w) for w in weightMatrix[0]) != min(len(w) for w in weightMatrix[0]) or len(weightMatrix[0][0]) != len(pattern):
        raise ValueError("Invalid arguments for pattern recognition.")
    print(f'Распознавание образа с пороговым значением активации {weightMatrix[1]} и порогом нейрона смещения {shiftLimit}')
    patternLength = len(pattern)
    neuronCount = len(weightMatrix[0])
    s = list(map(lambda x: 0, range(neuronCount)))
    y = list(map(lambda x: 0, range(neuronCount)))
    maxNeuronIndex = -1
    maxNeuronActivation = 0
    activationThreshhold = weightMatrix[1]
    for j in range(neuronCount):
        sj = sum(list(map(lambda k: pattern[k] * weightMatrix[0][j][k], range(len(pattern)))))
        s[j] = sj
        y[j] = 0 if sj < activationThreshhold else 1
    w0 = 1 if shiftLimit == 0 or sum(pattern) > shiftLimit else 0
    print(f'Активация нейронов: {(s, w0)}')
    print(f'Результат распознавания: {(y, w0)}')
    return (y, w0)

def getUnusedElementIndexes(weightMatrix: tuple[list[list[int]], float]) -> list[int]:
    '''Получение индексов неиспользуемых элементов образов по матрице весов'''
    if max(len(w) for w in weightMatrix[0]) != min(len(w) for w in weightMatrix[0]):
        raise ValueError("Invalid arguments for element analysis.")
    elementCount = len(weightMatrix[0][0])
    elementUsage = list(map(lambda x: 0, range(elementCount)))
    for i in range(len(weightMatrix[0])):
        for j in range(elementCount):
            elementUsage[j] += 1 if weightMatrix[0][i][j] != 0 else 0
    unusedElementIndexes = []
    for i in range(elementCount):
        if elementUsage[i] == 0:
            unusedElementIndexes.append(i)
    return unusedElementIndexes

imageFileSets = [getFiles("PatternStandarts", "^.*\.bmp$"), getFiles("PatternVariants", "^.*\.bmp$")]
for trainingImageSet in imageFileSets:
    print(f'Сет обучения:')
    trainingSet = getTrainingSet(trainingImageSet)
    for i in range(len(trainingImageSet)):
        print()
        print(trainingImageSet[i])
        print(trainingSet[i][0])
        print(f'{trainingSet[i][1]} - {trainingSet[i][2]}')
    weights = getWeightMatrix(trainingSet)
    print()
    print(f'Матрица весов с пороговым значением активации {weights[1]}:')
    for weight in weights[0]:
        print(weight)
    unusedElementIndexes = getUnusedElementIndexes(weights)
    print()
    print(f'Неиспользвемые элементы образа: {unusedElementIndexes} - {round(100 * len(unusedElementIndexes) / len(weights[0][0]), 2)}%')
    for recognitionImageSet in imageFileSets:
        print('\n------------------------------------\n')
        print(f'Сет распознавания:')
        for file in recognitionImageSet:
            print()
            print(file)
            for shiftLimit in [0, 10]:
                recognitionResult = recognizePattern(getImagePattern(Image.open(file)), weights, shiftLimit)
                resultName = next((n[2] for n in trainingSet if recognitionResult[1] == 1 and n[1] == recognitionResult[0]), None)
                print(f'Имя распознанного образа: {resultName}')
    print('\n------------------------------------\n')