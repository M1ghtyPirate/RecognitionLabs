from genericpath import exists
import os
import random
import re
import shutil
from datetime import datetime
import sqlite3

class symptom:
    id: int
    questionId: int
    symptom: str

class symptomQuestion:
    id: int
    question: str
    symptoms: list[symptom]

class diagnosisSymptom:
    id: int
    diagnosisId: int
    symptom: symptom
    pXW: float
    pXNoW: float 
    def getPXWCalc(self) -> float:
        '''Расчетная условная вероятность диагноза'''
        return (self.pXW if self.pXW > self.pXNoW else (1 - self.pXW))
    def getPXNoWCalc(self) -> float:
        '''Расчетная условная вероятность не этого диагноза'''
        return (self.pXNoW if self.pXW > self.pXNoW else (1 - self.pXNoW))

class diagnosis:
    id: int
    diagnosis: str
    p: float
    diagnosisSymptoms: list[diagnosisSymptom]
    def getPWX(self) -> float:
        '''Вероятность диагноза при всех положительных симптомах'''
        result = 1
        for diagnosisSymptom in self.diagnosisSymptoms:
            result *= diagnosisSymptom.getPXWCalc()
        return result
    def getPNoWX(self) -> float:
        '''Вероятность не этого диагноза при всех положительных симптомах'''
        result = 1
        for diagnosisSymptom in self.diagnosisSymptoms:
            result *= diagnosisSymptom.getPXNoWCalc()
        return result
    def getPWNoX(self) -> float:
        '''Вероятность диагноза при всех отрицательных симптомах'''
        result = 1
        for diagnosisSymptom in self.diagnosisSymptoms:
            result *= 1 - diagnosisSymptom.getPXWCalc()
        return result
    def getPNoWNoX(self) -> float:
        '''Вероятность не этого диагноза при всех отрицательных симптомах'''
        result = 1
        for diagnosisSymptom in self.diagnosisSymptoms:
            result *= 1 - diagnosisSymptom.getPXNoWCalc()
        return result
    def getPMax(self) -> float:
        '''Максимально возможная вероятность'''
        return self.p * self.getPWX() / (self.p * self.getPWX() + (1 - self.p) * self.getPNoWX())
    def getPMin(self) -> float:
        '''Минимально возможная вероятность'''
        return self.p * self.getPWNoX() / (self.p * self.getPWNoX() + (1 - self.p) * self.getPNoWNoX())
    
class dataBatch:
    symptoms: list[symptom]
    symptomQuestions: list[symptomQuestion]
    diagnosisSymptoms: list[diagnosisSymptom]
    diagnoses: list[diagnosis]

def executeScriptFile(dbConnection: sqlite3.Connection, scriptPath: str) -> sqlite3.Cursor:
    '''Выполнения файла SQL скрипта'''
    if not exists(scriptPath):
        raise ValueError("Script file not found.")
    scriptFile = open(scriptPath)
    cursor = dbConnection.execute(scriptFile.read())
    scriptFile.close()
    return cursor

def recreateDB():
    '''Пересоздание БД'''
    dbFileName = "expertDB.db"
    if exists(dbFileName):
        os.remove(dbFileName)
    lab03dir = "..\Lab03ExpertSystemDB"
    currentDir = os.getcwd()
    os.chdir(lab03dir)
    exec(open(f"Lab03ExpertSystemDB.py").read(), globals())
    dbFiles = [f'{lab03dir}\{f}' for f in os.listdir() if os.path.isfile(f) and re.fullmatch("^.*\.db$", f)]
    os.chdir(currentDir)
    shutil.copy(dbFiles[-1], "expertDB.db")
    
def getData(dbConnection: sqlite3.Connection) -> dataBatch:
    '''Формирование модели данных БД'''
    dbConnection.row_factory = sqlite3.Row
    dataRows = executeScriptFile(dbConnection, "SQL\GetData.sql").fetchall()
    symptoms = []
    symptomIds = []
    symptomQuestions = []
    symptomQuestionIds = []
    diagnosisSymptoms = []
    diagnosisSymptomIds = []
    diagnoses = []
    diagnosisIds = []
    for dataRow in dataRows:
        symptomId = dataRow["SymptomId"]
        if not symptomId in symptomIds:
            symptomIds.append(symptomId)
            rowSymptom = symptom()
            rowSymptom.id = symptomId
            rowSymptom.symptom = dataRow["Symptom"]
            rowSymptom.questionId = dataRow["SymptomQuestionId"]
            symptoms.append(rowSymptom)
        else:
            rowSymptom = next((s for s in symptoms if s.id == symptomId), None)
        symptomQuestionId = dataRow["SymptomQuestionId"]
        if not symptomQuestionId in symptomQuestionIds:
            symptomQuestionIds.append(symptomQuestionId)
            rowSymptomQuestion = symptomQuestion()
            rowSymptomQuestion.id = symptomQuestionId
            rowSymptomQuestion.question = dataRow["Question"]
            rowSymptomQuestion.symptoms = []
            symptomQuestions.append(rowSymptomQuestion)
        else:
            rowSymptomQuestion = next((q for q in symptomQuestions if q.id == symptomQuestionId), None)
        if not rowSymptom in rowSymptomQuestion.symptoms:
            rowSymptomQuestion.symptoms.append(rowSymptom)
        diagnosisSymptomId = dataRow["DiagnosisSymptomId"]
        diagnosisId = dataRow["DiagnosisId"]
        if diagnosisSymptomId != None and diagnosisId != None:
            if not diagnosisSymptomId in diagnosisSymptomIds:
                diagnosisSymptomIds.append(diagnosisSymptomId)
                rowDiagnosisSymptom = diagnosisSymptom()
                rowDiagnosisSymptom.id = diagnosisSymptomId
                rowDiagnosisSymptom.diagnosisId = diagnosisId
                rowDiagnosisSymptom.pXW = dataRow["PXW"]
                rowDiagnosisSymptom.pXNoW = dataRow["PXNoW"]
                rowDiagnosisSymptom.symptom = None
                diagnosisSymptoms.append(rowDiagnosisSymptom)
            else:
                rowDiagnosisSymptom = next((s for s in diagnosisSymptoms if s.id == diagnosisSymptomId), None)
            if not rowDiagnosisSymptom.symptom == rowSymptom:
                rowDiagnosisSymptom.symptom = rowSymptom
            if not diagnosisId in diagnosisIds:
                diagnosisIds.append(diagnosisId)
                rowDiagnosis = diagnosis()
                rowDiagnosis.id = diagnosisId
                rowDiagnosis.diagnosis = dataRow["Diagnosis"]
                rowDiagnosis.p = dataRow["P"]
                rowDiagnosis.diagnosisSymptoms = []
                diagnoses.append(rowDiagnosis)
            else:
                rowDiagnosis = next((d for d in diagnoses if d.id == diagnosisId), None)
            if not rowDiagnosisSymptom in rowDiagnosis.diagnosisSymptoms:
                rowDiagnosis.diagnosisSymptoms.append(rowDiagnosisSymptom)
    data = dataBatch()
    data.symptoms = symptoms
    data.symptomQuestions = symptomQuestions
    data.diagnosisSymptoms = diagnosisSymptoms
    data.diagnoses = diagnoses
    return data
    
def getSymptomsByAvgP(data: dataBatch) -> list[tuple[symptom, float]]:
    '''Симптомы отсортированные по убыванию средней вероятности связанных диагнозов'''
    symptomUsage = {}
    symptomAvgP = {}
    for diagnosis in data.diagnoses:
        for diagnosisSymptom in diagnosis.diagnosisSymptoms:
            if not symptomUsage.__contains__(diagnosisSymptom.symptom.id):
                symptomUsage[diagnosisSymptom.symptom.id] = 0
                symptomAvgP[diagnosisSymptom.symptom.id] = 0.0
            symptomUsage[diagnosisSymptom.symptom.id] += 1
            symptomAvgP[diagnosisSymptom.symptom.id] += diagnosis.p
    for key in symptomAvgP.keys():
        symptomAvgP[key] = symptomAvgP[key] / symptomUsage[key]
    symptoms = list(map(lambda p: (next((s for s in data.symptoms if s.id == p[0]), None), p[1]), symptomAvgP.items()))
    symptoms.sort(key = lambda s: s[1], reverse = True)
    return symptoms

def printDiagnoses(diagnoses: list[diagnosis]):
    '''Вывод текущих данных по диагнозам'''
    for d in diagnoses:
        print(f'{d.diagnosis} - {d.p} / {d.getPMin()} / {d.getPMax()}')

def askSymptomQuestion(id: int, data: dataBatch):
    '''Получение ответа на вопрос с перерасчетом данных'''
    question = next((s for s in data.symptomQuestions if s.id == id), None)
    print(f'{question.id}. {question.question}')
    possibleAnswers = list(map(lambda i: i, range(len(question.symptoms))))
    for i in possibleAnswers:
        print(f'\t{i}. {question.symptoms[i].symptom}')
    while(True):
        answer = input()
        if re.fullmatch('^[0-9]+$', answer) and int(answer) in possibleAnswers:
            break
        print(f'Некорректный ответ')
    acceptSymptom(question.symptoms[int(answer)].id, data)

def acceptSymptom(symptomId: int, data: dataBatch):
    '''Подтвержение симптома с перерасчетом данных'''
    acceptedSymptom = next((s for s in data.symptoms if s.id == symptomId), None)
    answeredQuestion = next((s for s in data.symptomQuestions if s.id == acceptedSymptom.questionId), None)
    for d in data.diagnoses:
        for ds in d.diagnosisSymptoms:
            if ds.symptom == acceptedSymptom:
                d.p = d.p * ds.pXW / (d.p * ds.pXW + (1 - d.p) * ds.pXNoW)
                d.diagnosisSymptoms.remove(ds)
            elif ds.symptom in answeredQuestion.symptoms:
                d.p = d.p * (1 - ds.pXW) / (d.p * (1 - ds.pXW) + (1 - d.p) * (1 - ds.pXNoW))
                d.diagnosisSymptoms.remove(ds)
                
def removeUnprobableDiagnoses(data: dataBatch):
    '''Удаление из данных неподходящих диагнозов'''
    pMinResult = 0.0
    diagnosisResult: diagnosis
    for d in data.diagnoses:        
        if d.getPMax() < d.p:
            data.diagnoses.remove(d)
            continue
        pMin = d.getPMin()
        if pMin > pMinResult:
            pMinResult = pMin
            diagnosisResult = d
    for d in data.diagnoses:
        if d != diagnosisResult and d.getPMax() >= pMinResult:
            return
    data.diagnoses = [ diagnosisResult ]
    
def findDiagnosisByProbabilityThreshhold(probabilityThreshhold: float, data: dataBatch) -> diagnosis:
    '''Поиск диагноза с вероятностью выше указанной'''
    for d in data.diagnoses:
        if d.p > probabilityThreshhold:
            return d
    return None

#recreateDB()
dbConnection = sqlite3.connect("expertDB.db")
while(True):
    data = getData(dbConnection)
    diagnosisResult: diagnosis = None
    while(diagnosisResult == None and len(data.diagnoses) > 1):
        printDiagnoses(data.diagnoses)
        symptomsByP = getSymptomsByAvgP(data)
        askSymptomQuestion(symptomsByP[0][0].questionId, data)
        diagnosisResult = findDiagnosisByProbabilityThreshhold(0.95, data)
        removeUnprobableDiagnoses(data)
    diagnosisResult = data.diagnoses[0].diagnosis if diagnosisResult == None else diagnosisResult
    print(f'Рекомендация: {diagnosisResult.diagnosis}')
    print(f'Повторить? (y/n)')
    if not re.fullmatch('^[yY]|([yY][eE][sS])$', input()):
        break
dbConnection.close()