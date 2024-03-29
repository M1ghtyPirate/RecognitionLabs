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
        raise ValueError("Invalid arguments for training set forming.")
    trainingSet = []
    for img in images:
        imgPattern = []
        resultPattern = list(map(lambda x: 1 if x == len(trainingSet) else 0, range(len(images))))
        for j in range(img.height):
            for i in range(img.width):
                imgPattern.append(img.getpixel((i, j)))
        trainingSet.append((imgPattern, resultPattern))
    return trainingSet

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