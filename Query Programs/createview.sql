CREATE VIEW BadDurationVisitsView AS
SELECT
    v.patientID,
    v.dentistID,
    v.visitStartTimestamp,
    v.visitDuration,
    totalDuration.totalTreatmentDuration
FROM 
    Visits v,
    (
        SELECT 
            tdv.patientID,
            tdv.dentistID,
            tdv.visitStartTimestamp,
            SUM(dt.treatmentDuration) AS totalTreatmentDuration
        FROM 
            TreatmentsDuringVisits tdv, DentalTreatments dt
        WHERE
            tdv.treatmentType = dt.treatmentType
        GROUP BY 
            tdv.patientID, tdv.dentistID, tdv.visitStartTimestamp
    ) AS totalDuration
WHERE 
    v.patientID = totalDuration.patientID 
    AND v.dentistID = totalDuration.dentistID 
    AND v.visitStartTimestamp = totalDuration.visitStartTimestamp
    AND (v.visitDuration - totalDuration.totalTreatmentDuration >= INTERVAL '5 minutes' 
         OR totalDuration.totalTreatmentDuration - v.visitDuration >= INTERVAL '5 Minutes');
