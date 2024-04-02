from datetime import datetime
from genericpath import exists
import sqlite3

def executeScriptFile(dbConnection: sqlite3.Connection, scriptPath: str):
    '''Выполнения файла SQL скрипта'''
    if not exists(scriptPath):
        raise ValueError("Script file not found.")
    scriptFile = open(scriptPath)
    dbConnection.executescript(scriptFile.read())
    scriptFile.close()

def createDB(path: str):
    '''Создание и заполнение БД, вывод содержания'''
    dbConnection = sqlite3.connect(path)
    executeScriptFile(dbConnection, "SQL\\CreateTables.sql")
    executeScriptFile(dbConnection, "SQL\\InsertData.sql")
    dbConnection.commit()
    symptoms = dbConnection.execute(
        """SELECT * 
        FROM Diagnoses 
        JOIN DiagnosisSymptoms
            ON Diagnoses.Id = DiagnosisSymptoms.DiagnosisId 
        JOIN Symptoms 
            ON DiagnosisSymptoms.SymptomId = Symptoms.Id 
        JOIN SymptomQuestions 
            ON Symptoms.QuestionId = SymptomQuestions.Id"""
    )
    rows = symptoms.fetchall()
    for row in rows:
        print(row)
    dbConnection.close()
        
createDB(f'expertDB_{datetime.now().strftime("%Y%m%d-%H%M%S.%f")}.db')