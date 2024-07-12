SELECT DISTINCT tdv.patientID, tdv.dentistID, tdv.visitStartTimestamp, tdv.toothNumber, tdv.treatmentType
FROM TreatmentsDuringVisits tdv
	JOIN Dentists d ON tdv.dentistID = d.dentistID
	JOIN Patients p ON tdv.patientID = p.patientID
	JOIN DentalTreatments dt ON tdv.treatmentType = dt.treatmentType
WHERE tdv.wasPaymentReceived = FALSE 
    AND DATE(tdv.visitStartTimestamp) >= '2024-01-12'
    AND d.address LIKE '%en%'
    AND dt.treatmentFee >= 50.00
    AND p.creditCardNumber IS NULL;