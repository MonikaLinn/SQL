SELECT DISTINCT tdv.dentistID AS theDentistID
FROM TreatmentsDuringVisits tdv, Dentists d, Teeth t
WHERE d.dentalSchool != 'UCLA School of Dentistry'
    AND tdv.toothNumber = t.toothNumber 
    AND tdv.dentistID = d.dentistID
    AND t.quadrant = 'TL'
GROUP BY 
    tdv.dentistID, tdv.toothNumber
HAVING COUNT(DISTINCT tdv.patientID) >= 2;


