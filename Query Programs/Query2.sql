SELECT DISTINCT p.address, p.patientID
FROM Patients p
WHERE p.creditCardType = 'V'
    AND p.patientID NOT IN(
        SELECT DISTINCT v.patientID
        FROM Visits v, Dentists d
        WHERE d.graduationDate < '2005-02-27'
        AND v.dentistID = d.dentistID
    )
ORDER BY p.address desc, p.patientID asc;
