SELECT
    d.dentistID,
    d.dentistName,
    INTERVAL '1 second' * SUM(FLOOR(ABS(EXTRACT(EPOCH FROM bdv.totalTreatmentDuration) - EXTRACT(EPOCH FROM bdv.visitDuration))/60)) AS DurationDifference,
    COUNT(*) AS badDurationVisitsCount
FROM
    BadDurationVisitsView bdv, Dentists d
WHERE 
    bdv.dentistID = d.dentistID
GROUP BY
    d.dentistID, d.dentistName;

-- dentistid |   dentistname   | durationdifference | baddurationvisitscount
-----------+-----------------+--------------------+------------------------
--        11 | Michael Johnson | 00:00:28           |                      1
--        33 | David Smith     | 00:01:00           |                      3

DELETE FROM TreatmentsDuringVisits
WHERE patientID = 5
AND dentistID = 33
AND visitStartTimestamp = TIMESTAMP '2024-03-30 15:00:00'
AND toothNumber = 32
AND treatmentType = 'Extraction';

DELETE FROM TreatmentsDuringVisits
WHERE patientID = 5
AND dentistID = 11
AND visitStartTimestamp = TIMESTAMP '2024-03-19 14:45:00'
AND toothNumber = 31
and treatmentType = 'Filling';

-- dentistid | dentistname | durationdifference | baddurationvisitscount
-----------+-------------+--------------------+------------------------
--        33 | David Smith | 00:00:40           |                      2

-- The output of the query is different from the previous run. 