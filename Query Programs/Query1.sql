SELECT DISTINCT p.patientName AS thePatientName, d.dentistName AS theDentistName, v.visitDuration AS theVisitLength
FROM Patients p, Dentists d, Visits v
WHERE p.patientName LIKE 'J%'
    AND d.isMemberADA = TRUE
    AND v.visitDuration > INTERVAL '00:45'
    AND v.patientID = p.patientID
    AND v.dentistID = d.dentistID;