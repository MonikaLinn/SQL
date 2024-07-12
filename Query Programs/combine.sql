BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
UPDATE DentalTreatments dt 
SET 
    treatmentDuration = udt.treatmentDuration, 
    treatmentFee = dt.treatmentFee + 2.00
FROM UpgradeDentalTreatments udt
WHERE 
    dt.treatmentType = udt.treatmentType;
INSERT INTO DentalTreatments (treatmentType, treatmentDuration, treatmentFee)
SELECT treatmentType, treatmentDuration, 34.50
FROM UpgradeDentalTreatments udt
WHERE NOT EXISTS (
    SELECT * 
    FROM DentalTreatments dt
    WHERE dt.treatmentType = udt.treatmentType
);
COMMIT TRANSACTION;