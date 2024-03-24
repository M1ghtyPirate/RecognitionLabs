import array
from datetime import datetime
import inspect
from math import sqrt
import sys
from typing import Callable
from numpy import append

# Множество образов
originalPatterns = [
        [0, 1, 1]
        ,[0, 1, 7]
        ,[5, 7, 4]
        ,[0, 5, 5]
        ,[9, 4, 5]
        ,[7, 1, 2]
        ,[10, 0, 19]
        ,[0, 12, 7]
        ,[-5, -4, 5]
        ,[20, 10, 15]
        ,[0, 16, -16]
        ,[-1, 9, -30]
        ,[18, 0, 17]
        ,[6, 18, 4]
        ,[17, 0, 11]
        ,[14, 16, 18]
        ,[5, 13, 0]
        ,[-5, -4, 0]
        ,[5, 15, -11]
        ,[-3, 10, -35]
        ,[16, 2, 15]
        ,[6, 15, 3]
        ,[-9, -2, 5]
        ,[0, 0, 3]
        ,[19, 17, 11]
        ,[6, 13, -14]
        ,[-4, 5, -25]
        ,[15, 12, 20]
        ,[-2, 10, -32]
        ,[7, 2, 0]
    ]

def euclidDist(l: list[float], p: list[float]) -> float:
    '''Евклидово расстояние между образами/EDPD'''
    if len(l) != len(p):
        raise ValueError("Invalid arguments for distance calculation.")
    
    result = 0
    for i in range(len(l)):
        result += pow((l[i] - p[i]), 2)
        
    return result

def dominationDist(l: list[float], p: list[float]) -> float:
    '''Расстояние доминирования между образами/DDPD'''
    if len(l) != len(p):
        raise ValueError("Invalid arguments for distance calculation.")
    
    result = 0
    for i in range(len(l)):
        result = max(result, abs(l[i] - p[i]))
        
    return result

def centerClusterDist(w1: list[list[float]], w2: list[list[float]], distFunc: Callable[[list[float], list[float]], float]) -> float:
    '''Расстояние между центрами кластеров/CCCD'''
    if max(len(x) for x in w1) != min(len(x) for x in w1) or max(len(x) for x in w2) != min(len(x) for x in w2) or max(len(x) for x in w1) != max(len(x) for x in w2):
        raise ValueError("Invalid arguments for distance calculation.")
    
    w1center = list(map(lambda x: 0.0, w1[0]))
    w2center = list(map(lambda x: 0.0, w1[0]))
    for i in range(len(w1)):
        for j in range(len(w1[i])):
            w1center[j] += w1[i][j]
    for i in range(len(w2)):
        for j in range(len(w2[i])):
            w2center[j] += w2[i][j]
    for i in range(len(w1center)):
        w1center[i] = w1center[i] / len(w1)
        w2center[i] = w2center[i] / len(w2)

    return distFunc(w1center, w2center)

def nearestNeighborClusterDist(w1: list[list[float]], w2: list[list[float]], distFunc: Callable[[list[float], list[float]], float]) -> float:
    '''Расстояние ближнего соседа между кластерами/NNCD'''
    if max(len(x) for x in w1) != min(len(x) for x in w1) or max(len(x) for x in w2) != min(len(x) for x in w2) or max(len(x) for x in w1) != max(len(x) for x in w2):
        raise ValueError("Invalid arguments for distance calculation.")
    
    result = sys.maxsize
    for l in w1:
        for p in w2:
            result = min(result, distFunc(l, p))
            
    return result

def joinClusterization(
            patterns: list[list[float]], 
            distFunc: Callable[[list[float], list[float]], float], 
            clusterDistFunction: Callable[[list[list[float]], list[list[float]], Callable[[list[float], list[float]], float]], float], 
            cutoffDist: float
        ) -> list[list[list[float]]]:
    '''Кластеризация слиянием/JC'''
    if max(len(x) for x in patterns) != min(len(x) for x in patterns):
        raise ValueError("Invalid arguments for clusterization.")
    
    clusters = list(map(lambda x: [x], patterns))
    w1nearest = w2nearest = clusters[0]
    nearestDist = 0
    while nearestDist < cutoffDist and len(clusters) > 1:
        if w1nearest != w2nearest:
            clusters.remove(w2nearest)
            w1nearest.extend(w2nearest)
            w2nearest = w1nearest
            nearestDist = 0
        for w1 in clusters:
            for w2 in clusters:
                if w1 == w2:
                    continue
                dist = clusterDistFunction(w1, w2, distFunc)
                if dist < nearestDist or w1nearest == w2nearest:
                    w1nearest = w1
                    w2nearest = w2
                    nearestDist = dist
                    
    return clusters

def normalizePatterns(patterns: list[list[float]]) -> list[list[float]]:
    '''Нормализация образов/NPs'''
    if max(len(x) for x in patterns) != min(len(x) for x in patterns):
        raise ValueError("Invalid arguments for normalization.")
    maxParamValues = []
    minParamValues = []
    for i in range(len(patterns[0])):
        maxParamValues.append(max(l[i] for l in patterns))
        minParamValues.append(min(l[i] for l in patterns))
    return list(map(lambda l: normalizePattern(l, minParamValues, maxParamValues), patterns))

def normalizePattern(pattern: list[float], minParamValues: list[float], maxParamValues: list[float]) -> list[float]:
    '''Нормализация образа/NP'''
    if len(pattern) != len(minParamValues) or len(pattern) != len(maxParamValues):
        raise ValueError("Invalid arguments for normalization.")
    normalizedPattern = []
    for i in range(len(pattern)):
        normalizedPattern.append((pattern[i] - minParamValues[i]) / (maxParamValues[i] - minParamValues[i]))
    return normalizedPattern

normalizedPatterns = normalizePatterns(originalPatterns)
patternSets = [originalPatterns, normalizedPatterns]

for patternSet in patternSets:
    for clusterDist in [centerClusterDist, nearestNeighborClusterDist]:
        for dist in [euclidDist, dominationDist]:
            for cutoffDist in [0.15, 0.30, 15, 30]:
                clusters = joinClusterization(patternSet, dist, clusterDist, cutoffDist)
                fileName = f'{inspect.getdoc(joinClusterization).split("/")[1]}_{inspect.getdoc(dist).split("/")[1]}_{inspect.getdoc(clusterDist).split("/")[1]}_{cutoffDist}_{datetime.now().strftime("%Y%m%d-%H%M%S.%f")}.txt'.replace(" ", "_")
                file = open(fileName, "x", encoding="utf-8")
                patternLine = "Множество образов:"
                print(patternLine)
                file.write(patternLine + "\n")
                for p in patternSet:
                    print(p)
                    file.write(str(p) + "\n")
                    
                file.write("\n")
                infoLine = f'Кластеризация: {inspect.getdoc(joinClusterization).split("/")[0]}; расстояние между образами: {inspect.getdoc(dist).split("/")[0]}; расстояние между кластерами: {inspect.getdoc(clusterDist).split("/")[0]}; пороговое расстояние между кластерами: {cutoffDist};'
                print(infoLine)
                file.write(infoLine + "\n")
                for i in range(len(clusters)):
                    clusterLine = f'Кластер #{i}:'
                    print(clusterLine)
                    file.write(clusterLine + "\n")
                    for p in clusters[i]:
                        print(p)
                        file.write(str(p) + "\n")
                file.close()
            