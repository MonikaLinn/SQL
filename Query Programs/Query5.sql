SELECT DISTINCT dentistID, dentistName, address
FROM Dentists 
WHERE graduationDate = (
    SELECT
        MIN(graduationDate)
    FROM
        Dentists
    );