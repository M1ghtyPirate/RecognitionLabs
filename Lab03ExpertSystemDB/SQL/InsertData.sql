INSERT INTO SymptomQuestions (Question)
VALUES ('����� ��� ��������������?')
	,('�������������� ��� ������?')
	,('�������� ��� ��������?')
	,('������� ��� ��������?')
	,('����� ��� ������?')
	,('�����������?')
	,('������?')
	,('�����?')
	,('�������?')
	,('�������?')
	,('����������?')
	,('�������?')
	,('�������?')
	,('�������?')
	,('��������?')
	,('������������?')
	,('�����?')
	,('���������?')
	,('�������?')
	,('�����������?');

INSERT INTO Symptoms (QuestionId, Symptom)
VALUES ((SELECT Id FROM SymptomQuestions WHERE Question = '����� ��� ��������������?' LIMIT 1), '�����')
	,((SELECT Id FROM SymptomQuestions WHERE Question = '����� ��� ��������������?' LIMIT 1), '��������������')
	,((SELECT Id FROM SymptomQuestions WHERE Question = '�������������� ��� ������?' LIMIT 1), '��������������')
	,((SELECT Id FROM SymptomQuestions WHERE Question = '�������������� ��� ������?' LIMIT 1), '������')
	,((SELECT Id FROM SymptomQuestions WHERE Question = '�������� ��� ��������?' LIMIT 1), '��������')
	,((SELECT Id FROM SymptomQuestions WHERE Question = '�������� ��� ��������?' LIMIT 1), '��������')
	,((SELECT Id FROM SymptomQuestions WHERE Question = '������� ��� ��������?' LIMIT 1), '�������')
	,((SELECT Id FROM SymptomQuestions WHERE Question = '������� ��� ��������?' LIMIT 1), '��������')
	,((SELECT Id FROM SymptomQuestions WHERE Question = '����� ��� ������?' LIMIT 1), '�����')
	,((SELECT Id FROM SymptomQuestions WHERE Question = '����� ��� ������?' LIMIT 1), '������')
	,((SELECT Id FROM SymptomQuestions WHERE Question = '�����������?' LIMIT 1), '��')
	,((SELECT Id FROM SymptomQuestions WHERE Question = '�����������?' LIMIT 1), '���')
	,((SELECT Id FROM SymptomQuestions WHERE Question = '������?' LIMIT 1), '��')
	,((SELECT Id FROM SymptomQuestions WHERE Question = '������?' LIMIT 1), '���')
	,((SELECT Id FROM SymptomQuestions WHERE Question = '�����?' LIMIT 1), '��')
	,((SELECT Id FROM SymptomQuestions WHERE Question = '�����?' LIMIT 1), '���')
	,((SELECT Id FROM SymptomQuestions WHERE Question = '�������?' LIMIT 1), '��')
	,((SELECT Id FROM SymptomQuestions WHERE Question = '�������?' LIMIT 1), '���')
	,((SELECT Id FROM SymptomQuestions WHERE Question = '�������?' LIMIT 1), '��')
	,((SELECT Id FROM SymptomQuestions WHERE Question = '�������?' LIMIT 1), '���')
	,((SELECT Id FROM SymptomQuestions WHERE Question = '����������?' LIMIT 1), '��')
	,((SELECT Id FROM SymptomQuestions WHERE Question = '����������?' LIMIT 1), '���')
	,((SELECT Id FROM SymptomQuestions WHERE Question = '�������?' LIMIT 1), '��')
	,((SELECT Id FROM SymptomQuestions WHERE Question = '�������?' LIMIT 1), '���')
	,((SELECT Id FROM SymptomQuestions WHERE Question = '�������?' LIMIT 1), '��')
	,((SELECT Id FROM SymptomQuestions WHERE Question = '�������?' LIMIT 1), '���')
	,((SELECT Id FROM SymptomQuestions WHERE Question = '�������?' LIMIT 1), '��')
	,((SELECT Id FROM SymptomQuestions WHERE Question = '�������?' LIMIT 1), '���')
	,((SELECT Id FROM SymptomQuestions WHERE Question = '��������?' LIMIT 1), '��')
	,((SELECT Id FROM SymptomQuestions WHERE Question = '��������?' LIMIT 1), '���')
	,((SELECT Id FROM SymptomQuestions WHERE Question = '������������?' LIMIT 1), '��')
	,((SELECT Id FROM SymptomQuestions WHERE Question = '������������?' LIMIT 1), '���')
	,((SELECT Id FROM SymptomQuestions WHERE Question = '�����?' LIMIT 1), '��')
	,((SELECT Id FROM SymptomQuestions WHERE Question = '�����?' LIMIT 1), '���')
	,((SELECT Id FROM SymptomQuestions WHERE Question = '���������?' LIMIT 1), '��')
	,((SELECT Id FROM SymptomQuestions WHERE Question = '���������?' LIMIT 1), '���')
	,((SELECT Id FROM SymptomQuestions WHERE Question = '�������?' LIMIT 1), '��')
	,((SELECT Id FROM SymptomQuestions WHERE Question = '�������?' LIMIT 1), '���')
	,((SELECT Id FROM SymptomQuestions WHERE Question = '�����������?' LIMIT 1), '��')
	,((SELECT Id FROM SymptomQuestions WHERE Question = '�����������?' LIMIT 1), '���');

INSERT INTO Diagnoses (Diagnosis, APrioriProbability)
VALUES ('�� �������� ������ ��� �������', 0.075)
	,('����� ������ � ����������� ������', 0.3)
	,('���� ���������', 0.15)
	,('��������� ��������', 0.1)
	,('���������', 0.05)
	,('�������-����: ����� ���������', 0.05)
	,('�������', 0.15)
	,('���������� ������', 0.02)
	,('������ �����', 0.03)
	,('��� ���������', 0.02)
	,('������ ������', 0.025)
	,('�����', 0.03);

WITH SQ AS (
	SELECT Symptoms.Id SymptomId
		,Symptoms.Symptom Symptom
		,SymptomQuestions.Question SymptomQuestion
	FROM Symptoms 
		JOIN SymptomQuestions 
			ON Symptoms.QuestionId = SymptomQuestions.Id 
)
INSERT INTO DiagnosisSymptoms (DiagnosisId, SymptomId, SymptomProbability, DifferentDiagnosisSymptomProbability)
VALUES (
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '�� �������� ������ ��� �������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '����� ��� ��������������?' AND Symptom = '�����' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '�� �������� ������ ��� �������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�������������� ��� ������?' AND Symptom = '��������������' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '�� �������� ������ ��� �������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�������� ��� ��������?' AND Symptom = '��������' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '�� �������� ������ ��� �������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '������� ��� ��������?' AND Symptom = '�������' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '�� �������� ������ ��� �������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '����� ��� ������?' AND Symptom = '�����' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '�� �������� ������ ��� �������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�������?' AND Symptom = '��' LIMIT 1)
		,0.8
		,0.05
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '�� �������� ������ ��� �������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '������������?' AND Symptom = '��' LIMIT 1)
		,0.8
		,0.075
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '�� �������� ������ ��� �������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�����?' AND Symptom = '��' LIMIT 1)
		,0.8
		,0.4
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '����� ������ � ����������� ������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '����� ��� ��������������?' AND Symptom = '�����' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '����� ������ � ����������� ������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�������������� ��� ������?' AND Symptom = '��������������' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '����� ������ � ����������� ������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�������� ��� ��������?' AND Symptom = '��������' LIMIT 1)
		,0.8
		,0.4
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '����� ������ � ����������� ������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '������� ��� ��������?' AND Symptom = '��������' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '����� ������ � ����������� ������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '����� ��� ������?' AND Symptom = '������' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '����� ������ � ����������� ������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '����������?' AND Symptom = '��' LIMIT 1)
		,0.6
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '����� ������ � ����������� ������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�������?' AND Symptom = '��' LIMIT 1)
		,0.4
		,0.2
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '����� ������ � ����������� ������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�����������?' AND Symptom = '��' LIMIT 1)
		,0.8
		,0.3
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '���� ���������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '����� ��� ��������������?' AND Symptom = '�����' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '���� ���������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�������������� ��� ������?' AND Symptom = '������' LIMIT 1)
		,0.8
		,0.4
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '���� ���������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�������� ��� ��������?' AND Symptom = '��������' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '���� ���������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '������� ��� ��������?' AND Symptom = '�������' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '���� ���������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '����� ��� ������?' AND Symptom = '�����' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '���� ���������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�������?' AND Symptom = '��' LIMIT 1)
		,0.8
		,0.1
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '���� ���������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�����?' AND Symptom = '��' LIMIT 1)
		,0.8
		,0.4
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '���� ���������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '���������?' AND Symptom = '��' LIMIT 1)
		,0.4
		,0.175
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '���� ���������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�����������?' AND Symptom = '��' LIMIT 1)
		,0.6
		,0.35
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '��������� ��������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '����� ��� ��������������?' AND Symptom = '�����' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '��������� ��������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�������������� ��� ������?' AND Symptom = '������' LIMIT 1)
		,0.8
		,0.4
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '��������� ��������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�������� ��� ��������?' AND Symptom = '��������' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '��������� ��������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '������� ��� ��������?' AND Symptom = '�������' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '��������� ��������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '����� ��� ������?' AND Symptom = '�����' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '��������� ��������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '������?' AND Symptom = '��' LIMIT 1)
		,0.6
		,0.3
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '��������� ��������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�������?' AND Symptom = '��' LIMIT 1)
		,0.8
		,0.1
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '��������� ��������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '��������?' AND Symptom = '��' LIMIT 1)
		,0.8
		,0.075
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '��������� ��������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�����?' AND Symptom = '��' LIMIT 1)
		,0.6
		,0.45
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '���������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '����� ��� ��������������?' AND Symptom = '�����' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '���������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�������������� ��� ������?' AND Symptom = '��������������' LIMIT 1)
		,0.8
		,0.4
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '���������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�������� ��� ��������?' AND Symptom = '��������' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '���������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '������� ��� ��������?' AND Symptom = '�������' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '���������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '����� ��� ������?' AND Symptom = '������' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '���������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '������?' AND Symptom = '��' LIMIT 1)
		,0.8
		,0.2
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '���������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�������?' AND Symptom = '��' LIMIT 1)
		,0.6
		,0.15
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '���������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '����������?' AND Symptom = '��' LIMIT 1)
		,0.6
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '���������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '��������?' AND Symptom = '��' LIMIT 1)
		,0.4
		,0.175
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '���������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '������������?' AND Symptom = '��' LIMIT 1)
		,0.4
		,0.1
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '���������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�����?' AND Symptom = '��' LIMIT 1)
		,0.4
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '���������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�������?' AND Symptom = '��' LIMIT 1)
		,0.8
		,0.1
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '�������-����: ����� ���������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '����� ��� ��������������?' AND Symptom = '��������������' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '�������-����: ����� ���������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�������������� ��� ������?' AND Symptom = '��������������' LIMIT 1)
		,0.8
		,0.4
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '�������-����: ����� ���������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�������� ��� ��������?' AND Symptom = '��������' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '�������-����: ����� ���������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '������� ��� ��������?' AND Symptom = '��������' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '�������-����: ����� ���������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '����� ��� ������?' AND Symptom = '�����' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '�������-����: ����� ���������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '������?' AND Symptom = '��' LIMIT 1)
		,0.6
		,0.3
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '�������-����: ����� ���������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�������?' AND Symptom = '��' LIMIT 1)
		,0.6
		,0.25
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '�������-����: ����� ���������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '����������?' AND Symptom = '��' LIMIT 1)
		,0.6
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '�������-����: ����� ���������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�������?' AND Symptom = '��' LIMIT 1)
		,0.8
		,0.1
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '�������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '����� ��� ��������������?' AND Symptom = '�����' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '�������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�������������� ��� ������?' AND Symptom = '��������������' LIMIT 1)
		,0.8
		,0.4
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '�������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�������� ��� ��������?' AND Symptom = '��������' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '�������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '������� ��� ��������?' AND Symptom = '�������' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '�������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '����� ��� ������?' AND Symptom = '������' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '�������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '������������?' AND Symptom = '��' LIMIT 1)
		,0.8
		,0.075
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '�������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�����?' AND Symptom = '��' LIMIT 1)
		,0.8
		,0.4
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '�������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '���������?' AND Symptom = '��' LIMIT 1)
		,0.8
		,0.075
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '���������� ������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '����� ��� ��������������?' AND Symptom = '�����' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '���������� ������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�������������� ��� ������?' AND Symptom = '��������������' LIMIT 1)
		,0.8
		,0.4
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '���������� ������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�������� ��� ��������?' AND Symptom = '��������' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '���������� ������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '������� ��� ��������?' AND Symptom = '��������' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '���������� ������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '����� ��� ������?' AND Symptom = '������' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '���������� ������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�����������?' AND Symptom = '��' LIMIT 1)
		,0.8
		,0.1
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '���������� ������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�����?' AND Symptom = '��' LIMIT 1)
		,0.8
		,0.1
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '���������� ������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�������?' AND Symptom = '��' LIMIT 1)
		,0.8
		,0.1
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '���������� ������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '����������?' AND Symptom = '��' LIMIT 1)
		,0.4
		,0.4
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '������ �����' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '����� ��� ��������������?' AND Symptom = '��������������' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '������ �����' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�������������� ��� ������?' AND Symptom = '������' LIMIT 1)
		,0.8
		,0.4
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '������ �����' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�������� ��� ��������?' AND Symptom = '��������' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '������ �����' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '������� ��� ��������?' AND Symptom = '��������' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '������ �����' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '����� ��� ������?' AND Symptom = '������' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '������ �����' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '������?' AND Symptom = '��' LIMIT 1)
		,0.6
		,0.3
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '������ �����' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�������?' AND Symptom = '��' LIMIT 1)
		,0.4
		,0.3
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '������ �����' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '����������?' AND Symptom = '��' LIMIT 1)
		,0.8
		,0.3
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '������ �����' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�������?' AND Symptom = '��' LIMIT 1)
		,0.4
		,0.175
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '������ �����' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�����������?' AND Symptom = '��' LIMIT 1)
		,0.8
		,0.3
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '��� ���������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '����� ��� ��������������?' AND Symptom = '��������������' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '��� ���������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�������������� ��� ������?' AND Symptom = '������' LIMIT 1)
		,0.8
		,0.4
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '��� ���������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�������� ��� ��������?' AND Symptom = '��������' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '��� ���������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '������� ��� ��������?' AND Symptom = '��������' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '��� ���������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '����� ��� ������?' AND Symptom = '�����' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '��� ���������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�����������?' AND Symptom = '��' LIMIT 1)
		,0.8
		,0.1
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '��� ���������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�������?' AND Symptom = '��' LIMIT 1)
		,0.8
		,0.2
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '��� ���������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�������?' AND Symptom = '��' LIMIT 1)
		,0.6
		,0.15
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '��� ���������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�����������?' AND Symptom = '��' LIMIT 1)
		,0.8
		,0.3
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '������ ������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '����� ��� ��������������?' AND Symptom = '�����' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '������ ������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�������������� ��� ������?' AND Symptom = '��������������' LIMIT 1)
		,0.8
		,0.4
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '������ ������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�������� ��� ��������?' AND Symptom = '��������' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '������ ������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '������� ��� ��������?' AND Symptom = '��������' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '������ ������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '����� ��� ������?' AND Symptom = '������' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '������ ������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�������?' AND Symptom = '��' LIMIT 1)
		,0.8
		,0.075
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '������ ������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�����?' AND Symptom = '��' LIMIT 1)
		,0.6
		,0.45
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '������ ������' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�����������?' AND Symptom = '��' LIMIT 1)
		,0.6
		,0.35
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '�����' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '����� ��� ��������������?' AND Symptom = '��������������' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '�����' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�������������� ��� ������?' AND Symptom = '��������������' LIMIT 1)
		,0.8
		,0.4
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '�����' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�������� ��� ��������?' AND Symptom = '��������' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '�����' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '������� ��� ��������?' AND Symptom = '�������' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '�����' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '����� ��� ������?' AND Symptom = '������' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '�����' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '������?' AND Symptom = '��' LIMIT 1)
		,0.4
		,0.4
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '�����' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '�����?' AND Symptom = '��' LIMIT 1)
		,0.4
		,0.1
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = '�����' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = '����������?' AND Symptom = '��' LIMIT 1)
		,0.8
		,0.3
	)