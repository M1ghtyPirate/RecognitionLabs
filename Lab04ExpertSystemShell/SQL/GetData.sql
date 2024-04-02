SELECT CASE WHEN Symptoms.Id = Answers.Id THEN Diagnoses.Id ELSE NULL END DiagnosisId
    ,Diagnoses.Diagnosis Diagnosis
    ,Diagnoses.APrioriProbability P
    ,CASE WHEN Symptoms.Id = Answers.Id THEN DiagnosisSymptoms.Id ELSE NULL END DiagnosisSymptomId
    ,DiagnosisSymptoms.SymptomProbability PXW
    ,DiagnosisSymptoms.DifferentDiagnosisSymptomProbability PXNoW
    ,Answers.Id SymptomId
    ,Answers.Symptom Symptom
    ,SymptomQuestions.Id SymptomQuestionId
    ,SymptomQuestions.Question Question
FROM Diagnoses 
    JOIN DiagnosisSymptoms
        ON Diagnoses.Id = DiagnosisSymptoms.DiagnosisId 
    JOIN Symptoms 
        ON DiagnosisSymptoms.SymptomId = Symptoms.Id 
    JOIN SymptomQuestions 
        ON Symptoms.QuestionId = SymptomQuestions.Id
    JOIN Symptoms Answers 
        ON SymptomQuestions.Id = Answers.QuestionId