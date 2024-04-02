from genericpath import exists
import os
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

class diagnosis:
    id: int
    diagnosis: str
    p: float
    pMax: float
    pMin: float
    diagnosisSymptoms: list[diagnosisSymptom]

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
    
def getData(dbConnection: sqlite3.Connection) -> tuple[list[symptom], list[symptomQuestion], list[diagnosisSymptom], list[diagnosis]]:
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
    return (symptoms, symptomQuestions, diagnosisSymptoms, diagnoses)
    
#recreateDB()
dbConnection = sqlite3.connect("expertDB.db")
data = getData(dbConnection)