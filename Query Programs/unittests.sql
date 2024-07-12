INSERT INTO Visits (patientID, dentistID, visitStartTimestamp)
VALUES (9, 11, '2023-12-15 09:00:00'); -- Patient 9 doesnt exist

INSERT INTO Visits (patientID, dentistID, visitStartTimestamp)
VALUES (1, 1, '2024-02-20 10:30:00'); --Dentist 1 doesnt exist

INSERT INTO TreatmentsDuringVisits (patientID, dentistID, visitStartTimestamp, toothNumber, treatmentType)
VALUES (2, 1, '2021-01-17 14:23:00', 20, 'Crown'); -- This visit doesnt exist in visits

UPDATE Visits 
SET visitDuration = INTERVAL '45 minutes'
WHERE patientID = 7;

UPDATE Visits --Should error
SET visitDuration = INTERVAL '0 minutes'
WHERE patientID = 1;

UPDATE Teeth
SET quadrant = 'TL'
WHERE toothNumber = 1;

UPDATE Teeth --Should error
SET quadrant = 'TU'
WHERE toothNumber = 2;

UPDATE Patients
SET creditCardType = 'A', creditCardNumber = 123456789
Where patientID = 1;

UPDATE Patients --Should error
SET creditCardType = NULL, creditCardNumber = 125487699
Where patientID = 1;