INSERT INTO SymptomQuestions (Question)
VALUES ('Фильм или мультипликация?')
	,('Полнометражный или сериал?')
	,('Взрослый или семейный?')
	,('Длинный или короткий?')
	,('Новый или старый?')
	,('Музыкальный?')
	,('Боевик?')
	,('Ужасы?')
	,('Триллер?')
	,('Комедия?')
	,('Фантастика?')
	,('Фэнтези?')
	,('Вестерн?')
	,('Военный?')
	,('Детектив?')
	,('Исторический?')
	,('Драма?')
	,('Мелодрама?')
	,('Комиксы?')
	,('Приключения?');

INSERT INTO Symptoms (QuestionId, Symptom)
VALUES ((SELECT Id FROM SymptomQuestions WHERE Question = 'Фильм или мультипликация?' LIMIT 1), 'Фильм')
	,((SELECT Id FROM SymptomQuestions WHERE Question = 'Фильм или мультипликация?' LIMIT 1), 'Мультипликация')
	,((SELECT Id FROM SymptomQuestions WHERE Question = 'Полнометражный или сериал?' LIMIT 1), 'Полнометражный')
	,((SELECT Id FROM SymptomQuestions WHERE Question = 'Полнометражный или сериал?' LIMIT 1), 'Сериал')
	,((SELECT Id FROM SymptomQuestions WHERE Question = 'Взрослый или семейный?' LIMIT 1), 'Взрослый')
	,((SELECT Id FROM SymptomQuestions WHERE Question = 'Взрослый или семейный?' LIMIT 1), 'Семейный')
	,((SELECT Id FROM SymptomQuestions WHERE Question = 'Длинный или короткий?' LIMIT 1), 'Длинный')
	,((SELECT Id FROM SymptomQuestions WHERE Question = 'Длинный или короткий?' LIMIT 1), 'Короткий')
	,((SELECT Id FROM SymptomQuestions WHERE Question = 'Новый или старый?' LIMIT 1), 'Новый')
	,((SELECT Id FROM SymptomQuestions WHERE Question = 'Новый или старый?' LIMIT 1), 'Старый')
	,((SELECT Id FROM SymptomQuestions WHERE Question = 'Музыкальный?' LIMIT 1), 'Да')
	,((SELECT Id FROM SymptomQuestions WHERE Question = 'Музыкальный?' LIMIT 1), 'Нет')
	,((SELECT Id FROM SymptomQuestions WHERE Question = 'Боевик?' LIMIT 1), 'Да')
	,((SELECT Id FROM SymptomQuestions WHERE Question = 'Боевик?' LIMIT 1), 'Нет')
	,((SELECT Id FROM SymptomQuestions WHERE Question = 'Ужасы?' LIMIT 1), 'Да')
	,((SELECT Id FROM SymptomQuestions WHERE Question = 'Ужасы?' LIMIT 1), 'Нет')
	,((SELECT Id FROM SymptomQuestions WHERE Question = 'Триллер?' LIMIT 1), 'Да')
	,((SELECT Id FROM SymptomQuestions WHERE Question = 'Триллер?' LIMIT 1), 'Нет')
	,((SELECT Id FROM SymptomQuestions WHERE Question = 'Комедия?' LIMIT 1), 'Да')
	,((SELECT Id FROM SymptomQuestions WHERE Question = 'Комедия?' LIMIT 1), 'Нет')
	,((SELECT Id FROM SymptomQuestions WHERE Question = 'Фантастика?' LIMIT 1), 'Да')
	,((SELECT Id FROM SymptomQuestions WHERE Question = 'Фантастика?' LIMIT 1), 'Нет')
	,((SELECT Id FROM SymptomQuestions WHERE Question = 'Фэнтези?' LIMIT 1), 'Да')
	,((SELECT Id FROM SymptomQuestions WHERE Question = 'Фэнтези?' LIMIT 1), 'Нет')
	,((SELECT Id FROM SymptomQuestions WHERE Question = 'Вестерн?' LIMIT 1), 'Да')
	,((SELECT Id FROM SymptomQuestions WHERE Question = 'Вестерн?' LIMIT 1), 'Нет')
	,((SELECT Id FROM SymptomQuestions WHERE Question = 'Военный?' LIMIT 1), 'Да')
	,((SELECT Id FROM SymptomQuestions WHERE Question = 'Военный?' LIMIT 1), 'Нет')
	,((SELECT Id FROM SymptomQuestions WHERE Question = 'Детектив?' LIMIT 1), 'Да')
	,((SELECT Id FROM SymptomQuestions WHERE Question = 'Детектив?' LIMIT 1), 'Нет')
	,((SELECT Id FROM SymptomQuestions WHERE Question = 'Исторический?' LIMIT 1), 'Да')
	,((SELECT Id FROM SymptomQuestions WHERE Question = 'Исторический?' LIMIT 1), 'Нет')
	,((SELECT Id FROM SymptomQuestions WHERE Question = 'Драма?' LIMIT 1), 'Да')
	,((SELECT Id FROM SymptomQuestions WHERE Question = 'Драма?' LIMIT 1), 'Нет')
	,((SELECT Id FROM SymptomQuestions WHERE Question = 'Мелодрама?' LIMIT 1), 'Да')
	,((SELECT Id FROM SymptomQuestions WHERE Question = 'Мелодрама?' LIMIT 1), 'Нет')
	,((SELECT Id FROM SymptomQuestions WHERE Question = 'Комиксы?' LIMIT 1), 'Да')
	,((SELECT Id FROM SymptomQuestions WHERE Question = 'Комиксы?' LIMIT 1), 'Нет')
	,((SELECT Id FROM SymptomQuestions WHERE Question = 'Приключения?' LIMIT 1), 'Да')
	,((SELECT Id FROM SymptomQuestions WHERE Question = 'Приключения?' LIMIT 1), 'Нет');

INSERT INTO Diagnoses (Diagnosis, APrioriProbability)
VALUES ('На западном фронте без перемен', 0.075)
	,('Гарри Поттер и философский камень', 0.3)
	,('Игра престолов', 0.15)
	,('Настоящий детектив', 0.1)
	,('Хранители', 0.05)
	,('Человек-паук: через вселенный', 0.05)
	,('Титаник', 0.15)
	,('Магазинчик ужасов', 0.02)
	,('Ковбой бибоп', 0.03)
	,('Мир кентавров', 0.02)
	,('Старый брехун', 0.025)
	,('Акира', 0.03);

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
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'На западном фронте без перемен' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Фильм или мультипликация?' AND Symptom = 'Фильм' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'На западном фронте без перемен' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Полнометражный или сериал?' AND Symptom = 'Полнометражный' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'На западном фронте без перемен' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Взрослый или семейный?' AND Symptom = 'Взрослый' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'На западном фронте без перемен' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Длинный или короткий?' AND Symptom = 'Длинный' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'На западном фронте без перемен' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Новый или старый?' AND Symptom = 'Новый' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'На западном фронте без перемен' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Военный?' AND Symptom = 'Да' LIMIT 1)
		,0.8
		,0.05
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'На западном фронте без перемен' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Исторический?' AND Symptom = 'Да' LIMIT 1)
		,0.8
		,0.075
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'На западном фронте без перемен' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Драма?' AND Symptom = 'Да' LIMIT 1)
		,0.8
		,0.4
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Гарри Поттер и философский камень' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Фильм или мультипликация?' AND Symptom = 'Фильм' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Гарри Поттер и философский камень' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Полнометражный или сериал?' AND Symptom = 'Полнометражный' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Гарри Поттер и философский камень' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Взрослый или семейный?' AND Symptom = 'Семейный' LIMIT 1)
		,0.8
		,0.4
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Гарри Поттер и философский камень' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Длинный или короткий?' AND Symptom = 'Короткий' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Гарри Поттер и философский камень' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Новый или старый?' AND Symptom = 'Старый' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Гарри Поттер и философский камень' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Фантастика?' AND Symptom = 'Да' LIMIT 1)
		,0.6
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Гарри Поттер и философский камень' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Фэнтези?' AND Symptom = 'Да' LIMIT 1)
		,0.4
		,0.2
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Гарри Поттер и философский камень' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Приключения?' AND Symptom = 'Да' LIMIT 1)
		,0.8
		,0.3
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Игра престолов' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Фильм или мультипликация?' AND Symptom = 'Фильм' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Игра престолов' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Полнометражный или сериал?' AND Symptom = 'Сериал' LIMIT 1)
		,0.8
		,0.4
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Игра престолов' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Взрослый или семейный?' AND Symptom = 'Взрослый' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Игра престолов' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Длинный или короткий?' AND Symptom = 'Длинный' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Игра престолов' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Новый или старый?' AND Symptom = 'Новый' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Игра престолов' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Фэнтези?' AND Symptom = 'Да' LIMIT 1)
		,0.8
		,0.1
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Игра престолов' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Драма?' AND Symptom = 'Да' LIMIT 1)
		,0.8
		,0.4
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Игра престолов' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Мелодрама?' AND Symptom = 'Да' LIMIT 1)
		,0.4
		,0.175
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Игра престолов' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Приключения?' AND Symptom = 'Да' LIMIT 1)
		,0.6
		,0.35
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Настоящий детектив' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Фильм или мультипликация?' AND Symptom = 'Фильм' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Настоящий детектив' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Полнометражный или сериал?' AND Symptom = 'Сериал' LIMIT 1)
		,0.8
		,0.4
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Настоящий детектив' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Взрослый или семейный?' AND Symptom = 'Взрослый' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Настоящий детектив' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Длинный или короткий?' AND Symptom = 'Длинный' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Настоящий детектив' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Новый или старый?' AND Symptom = 'Новый' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Настоящий детектив' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Боевик?' AND Symptom = 'Да' LIMIT 1)
		,0.6
		,0.3
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Настоящий детектив' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Триллер?' AND Symptom = 'Да' LIMIT 1)
		,0.8
		,0.1
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Настоящий детектив' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Детектив?' AND Symptom = 'Да' LIMIT 1)
		,0.8
		,0.075
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Настоящий детектив' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Драма?' AND Symptom = 'Да' LIMIT 1)
		,0.6
		,0.45
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Хранители' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Фильм или мультипликация?' AND Symptom = 'Фильм' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Хранители' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Полнометражный или сериал?' AND Symptom = 'Полнометражный' LIMIT 1)
		,0.8
		,0.4
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Хранители' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Взрослый или семейный?' AND Symptom = 'Взрослый' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Хранители' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Длинный или короткий?' AND Symptom = 'Длинный' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Хранители' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Новый или старый?' AND Symptom = 'Старый' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Хранители' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Боевик?' AND Symptom = 'Да' LIMIT 1)
		,0.8
		,0.2
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Хранители' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Триллер?' AND Symptom = 'Да' LIMIT 1)
		,0.6
		,0.15
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Хранители' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Фантастика?' AND Symptom = 'Да' LIMIT 1)
		,0.6
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Хранители' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Детектив?' AND Symptom = 'Да' LIMIT 1)
		,0.4
		,0.175
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Хранители' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Исторический?' AND Symptom = 'Да' LIMIT 1)
		,0.4
		,0.1
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Хранители' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Драма?' AND Symptom = 'Да' LIMIT 1)
		,0.4
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Хранители' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Комиксы?' AND Symptom = 'Да' LIMIT 1)
		,0.8
		,0.1
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Человек-паук: через вселенный' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Фильм или мультипликация?' AND Symptom = 'Мультипликация' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Человек-паук: через вселенный' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Полнометражный или сериал?' AND Symptom = 'Полнометражный' LIMIT 1)
		,0.8
		,0.4
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Человек-паук: через вселенный' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Взрослый или семейный?' AND Symptom = 'Семейный' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Человек-паук: через вселенный' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Длинный или короткий?' AND Symptom = 'Короткий' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Человек-паук: через вселенный' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Новый или старый?' AND Symptom = 'Новый' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Человек-паук: через вселенный' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Боевик?' AND Symptom = 'Да' LIMIT 1)
		,0.6
		,0.3
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Человек-паук: через вселенный' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Комедия?' AND Symptom = 'Да' LIMIT 1)
		,0.6
		,0.25
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Человек-паук: через вселенный' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Фантастика?' AND Symptom = 'Да' LIMIT 1)
		,0.6
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Человек-паук: через вселенный' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Комиксы?' AND Symptom = 'Да' LIMIT 1)
		,0.8
		,0.1
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Титаник' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Фильм или мультипликация?' AND Symptom = 'Фильм' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Титаник' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Полнометражный или сериал?' AND Symptom = 'Полнометражный' LIMIT 1)
		,0.8
		,0.4
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Титаник' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Взрослый или семейный?' AND Symptom = 'Взрослый' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Титаник' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Длинный или короткий?' AND Symptom = 'Длинный' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Титаник' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Новый или старый?' AND Symptom = 'Старый' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Титаник' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Исторический?' AND Symptom = 'Да' LIMIT 1)
		,0.8
		,0.075
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Титаник' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Драма?' AND Symptom = 'Да' LIMIT 1)
		,0.8
		,0.4
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Титаник' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Мелодрама?' AND Symptom = 'Да' LIMIT 1)
		,0.8
		,0.075
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Магазинчик ужасов' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Фильм или мультипликация?' AND Symptom = 'Фильм' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Магазинчик ужасов' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Полнометражный или сериал?' AND Symptom = 'Полнометражный' LIMIT 1)
		,0.8
		,0.4
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Магазинчик ужасов' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Взрослый или семейный?' AND Symptom = 'Взрослый' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Магазинчик ужасов' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Длинный или короткий?' AND Symptom = 'Короткий' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Магазинчик ужасов' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Новый или старый?' AND Symptom = 'Старый' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Магазинчик ужасов' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Музыкальный?' AND Symptom = 'Да' LIMIT 1)
		,0.8
		,0.1
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Магазинчик ужасов' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Ужасы?' AND Symptom = 'Да' LIMIT 1)
		,0.8
		,0.1
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Магазинчик ужасов' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Комедия?' AND Symptom = 'Да' LIMIT 1)
		,0.8
		,0.1
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Магазинчик ужасов' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Фантастика?' AND Symptom = 'Да' LIMIT 1)
		,0.4
		,0.4
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Ковбой бибоп' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Фильм или мультипликация?' AND Symptom = 'Мультипликация' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Ковбой бибоп' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Полнометражный или сериал?' AND Symptom = 'Сериал' LIMIT 1)
		,0.8
		,0.4
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Ковбой бибоп' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Взрослый или семейный?' AND Symptom = 'Взрослый' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Ковбой бибоп' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Длинный или короткий?' AND Symptom = 'Короткий' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Ковбой бибоп' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Новый или старый?' AND Symptom = 'Старый' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Ковбой бибоп' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Боевик?' AND Symptom = 'Да' LIMIT 1)
		,0.6
		,0.3
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Ковбой бибоп' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Комедия?' AND Symptom = 'Да' LIMIT 1)
		,0.4
		,0.3
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Ковбой бибоп' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Фантастика?' AND Symptom = 'Да' LIMIT 1)
		,0.8
		,0.3
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Ковбой бибоп' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Вестерн?' AND Symptom = 'Да' LIMIT 1)
		,0.4
		,0.175
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Ковбой бибоп' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Приключения?' AND Symptom = 'Да' LIMIT 1)
		,0.8
		,0.3
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Мир кентавров' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Фильм или мультипликация?' AND Symptom = 'Мультипликация' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Мир кентавров' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Полнометражный или сериал?' AND Symptom = 'Сериал' LIMIT 1)
		,0.8
		,0.4
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Мир кентавров' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Взрослый или семейный?' AND Symptom = 'Семейный' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Мир кентавров' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Длинный или короткий?' AND Symptom = 'Короткий' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Мир кентавров' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Новый или старый?' AND Symptom = 'Новый' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Мир кентавров' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Музыкальный?' AND Symptom = 'Да' LIMIT 1)
		,0.8
		,0.1
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Мир кентавров' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Комедия?' AND Symptom = 'Да' LIMIT 1)
		,0.8
		,0.2
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Мир кентавров' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Фэнтези?' AND Symptom = 'Да' LIMIT 1)
		,0.6
		,0.15
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Мир кентавров' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Приключения?' AND Symptom = 'Да' LIMIT 1)
		,0.8
		,0.3
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Старый брехун' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Фильм или мультипликация?' AND Symptom = 'Фильм' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Старый брехун' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Полнометражный или сериал?' AND Symptom = 'Полнометражный' LIMIT 1)
		,0.8
		,0.4
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Старый брехун' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Взрослый или семейный?' AND Symptom = 'Семейный' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Старый брехун' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Длинный или короткий?' AND Symptom = 'Короткий' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Старый брехун' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Новый или старый?' AND Symptom = 'Старый' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Старый брехун' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Вестерн?' AND Symptom = 'Да' LIMIT 1)
		,0.8
		,0.075
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Старый брехун' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Драма?' AND Symptom = 'Да' LIMIT 1)
		,0.6
		,0.45
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Старый брехун' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Приключения?' AND Symptom = 'Да' LIMIT 1)
		,0.6
		,0.35
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Акира' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Фильм или мультипликация?' AND Symptom = 'Мультипликация' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Акира' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Полнометражный или сериал?' AND Symptom = 'Полнометражный' LIMIT 1)
		,0.8
		,0.4
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Акира' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Взрослый или семейный?' AND Symptom = 'Взрослый' LIMIT 1)
		,0.8
		,0.6
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Акира' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Длинный или короткий?' AND Symptom = 'Длинный' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Акира' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Новый или старый?' AND Symptom = 'Старый' LIMIT 1)
		,0.8
		,0.5
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Акира' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Боевик?' AND Symptom = 'Да' LIMIT 1)
		,0.4
		,0.4
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Акира' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Ужасы?' AND Symptom = 'Да' LIMIT 1)
		,0.4
		,0.1
	)
	,(
		(SELECT Id FROM Diagnoses WHERE Diagnosis = 'Акира' LIMIT 1)
		,(SELECT SymptomId FROM SQ WHERE SymptomQuestion = 'Фантастика?' AND Symptom = 'Да' LIMIT 1)
		,0.8
		,0.3
	)