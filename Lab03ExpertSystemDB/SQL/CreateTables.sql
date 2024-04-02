CREATE TABLE IF NOT EXISTS SymptomQuestions (
	Id INTEGER PRIMARY KEY AUTOINCREMENT
	,Question TEXT
);

CREATE TABLE IF NOT EXISTS Symptoms (
	Id INTEGER PRIMARY KEY AUTOINCREMENT
	,QuestionId INTEGER
	,Symptom TEXT
	,FOREIGN KEY (QuestionId) REFERENCES SymptomQuestions (Id)
);

CREATE TABLE IF NOT EXISTS Diagnoses (
	Id INTEGER PRIMARY KEY AUTOINCREMENT
	,Diagnosis TEXT
	,APrioriProbability FLOAT
);

CREATE TABLE IF NOT EXISTS DiagnosisSymptoms (
	Id INTEGER PRIMARY KEY AUTOINCREMENT
	,DiagnosisId INT
	,SymptomId INT
	,SymptomProbability FLOAT
	,DifferentDiagnosisSymptomProbability FLOAT
	,FOREIGN KEY (DiagnosisId) REFERENCES Diagneses (Id)
	,FOREIGN KEY (SymptomId) REFERENCES Symptoms (Id)
);