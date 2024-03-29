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

def getTrainingSet(images: list[Image.Image]) -> list[tuple[list[int], list[int]]]:
    '''Формирование сета для обучения'''
    if max(img.width for img in images) != min(img.width for img in images) or max(img.height for img in images) != min(img.height for img in images):
        raise ValueError("Invalid arguments for training set formation.")
    trainingSet = []
    for img in images:
        imgPattern = []
        resultPattern = list(map(lambda x: 1 if x == len(trainingSet) else 0, range(len(images))))
        for j in range(img.height):
            for i in range(img.width):
                imgPattern.append(img.getpixel((i, j)))
        trainingSet.append((imgPattern, resultPattern))
    return trainingSet

def getWeightMatrix(trainingSet: list[tuple[list[int], list[int]]], maxCycles: int = 0) -> list[list[int]]:
    '''Формирование матрицы весов нейронов'''
    if max(len(p[0]) for p in trainingSet) != min(len(p[0]) for p in trainingSet) or max(len(p[1]) for p in trainingSet) != min(len(p[1]) for p in trainingSet) or maxCycles < 0:
        raise ValueError("Invalid arguments for weight matrix formation.")
    print(f'Balancing weight matrix' + '.' if maxCycles == 0 else f' for maximum of {maxCycles} cycle.')
    patternCount = len(trainingSet)
    patternLength = len(trainingSet[0][0])
    weightMatrix = [[0 for i in range(patternLength)] for j in range(patternCount)]
    zeroOutput = list(map(lambda x: 0, range(patternCount)))
    maxCycles = maxCycles if maxCycles > 0 else -1
    currentCycle = 0
    reportPercent = 0
    while maxCycles < 0 or currentCycle < maxCycles:
        weightsCorrected = False
        for i in range(patternCount):
            pattern = trainingSet[i]
            for j in range(patternCount):
                neuronWeights = weightMatrix[j]
                yj = sum(list(map(lambda k: pattern[0][k] * neuronWeights[k], range(patternLength))))
                tj = (pattern[1] if i == j else zeroOutput)[j]
                dy = 0 if yj == tj else (1 if yj < tj else -1)
                for k in range(patternLength):
                    dx = pattern[0][k] * dy
                    neuronWeights[k] += dx
                    weightsCorrected = weightsCorrected or abs(dx) > 0.5
        if not weightsCorrected:
            break
        if maxCycles > 0:
            currentCycle += 1
            percentDone = ceil(100 * currentCycle / maxCycles)
            if percentDone >= reportPercent:
                print(f'{reportPercent}% done.')
                reportPercent += 10
    return weightMatrix

def recognizePattern(pattern: list[int], weightMatrix: list[list[int]], shiftLimit: int = 0) -> list[int]:
    if max(len(w) for w in weightMatrix) != min(len(w) for w in weightMatrix) or len(weightMatrix[0]) != len(pattern):
        raise ValueError("Invalid arguments for pattern recognition.")
    patternLength = len(pattern)
    neuronCount = len(weightMatrix)
    y = list(map(lambda x: 0, range(neuronCount)))
    maxNeuronIndex = -1
    maxNeuronActivation = 0
    for i in range(neuronCount):
        yj = sum(list(map(lambda j: pattern[j] * weightMatrix[i][j], range(len(pattern)))))
        y[i] = yj
        if maxNeuronActivation < yj or maxNeuronIndex == -1:
            maxNeuronIndex = i
            maxNeuronActivation = yj
    print(f'Neuron activation: {y}')
    t = list(map(lambda x: 0, range(neuronCount)))
    if maxNeuronIndex >= 0:
        t[maxNeuronIndex] = 1
    return t

standartImageFiles = getFiles("PatternStandarts", "^.*\.bmp$")
if standartImageFiles == None or len(standartImageFiles) == 0:
    print("No standart images found for identification.")
    exit(1)

imgs = list(map(lambda x: Image.open(x), standartImageFiles))
# for f in standartImageFiles:
#     print(f)
#     img = Image.open(f)
#     printImg(img)
trainingSet = getTrainingSet(imgs)
for p in trainingSet:
     print(f'{p[0]} / {p[1]}')
weights = getWeightMatrix(trainingSet, 50000)
for w in weights:
    print(w)
    
for img in trainingSet:
    result = recognizePattern(img[0], weights)
    print(f'Target: {img[1]}\nResult: {result}')