CREATE OR REPLACE FUNCTION cancelSomeVisitsFunction(maxVisitCancellations INTEGER)
RETURNS INTEGER AS $$
DECLARE
    totalCancel INTEGER := 0;
    v_patientID INTEGER;
    v_patientName VARCHAR;
    v_overduePayments INTEGER;
    futureVisits INTEGER;

DECLARE cancelCursor CURSOR FOR 
        SELECT p.patientID,
               p.patientName,
               COUNT(tdv.patientID) AS overduePayments
        FROM Patients p
        LEFT JOIN TreatmentsDuringVisits tdv 
        ON p.patientID = tdv.patientID
           AND DATE(tdv.visitStartTimestamp) <= '2024-06-04'
           AND tdv.wasPaymentReceived = FALSE
        GROUP BY p.patientID, p.patientName
        HAVING COUNT(tdv.patientID) > 0
        ORDER BY COUNT(tdv.patientID) DESC, p.patientName ASC;

BEGIN
    IF maxVisitCancellations <= 0 THEN
        RETURN -1;
    END IF;

    OPEN cancelCursor;
    LOOP
        FETCH cancelCursor INTO v_patientID, v_patientName, v_overduePayments;
        EXIT WHEN NOT FOUND OR maxVisitCancellations <= totalCancel;

        -- Check the number of future visits for the current patient
        SELECT COUNT(*)
        INTO futureVisits
        FROM Visits v
        WHERE v.patientID = v_patientID
        AND DATE(v.visitStartTimestamp) > DATE('2024-06-04');

        EXIT WHEN totalCancel + futureVisits > maxVisitCancellations;

        -- If there are future visits and within cancellation limit
        IF totalCancel + futureVisits <= maxVisitCancellations THEN
            IF futureVisits IS NOT NULL AND futureVisits > 0 THEN

                -- Cancel the future visits for the patient within the limit
                DELETE FROM Visits
                WHERE patientID = v_patientID
                AND DATE(visitStartTimestamp) > '2024-06-04';

                -- Update the total cancelled visits count
                totalCancel := totalCancel + futureVisits;
                RAISE NOTICE 'Total Cancelled: %', totalCancel;

            END IF;
        END IF;
    END LOOP;

    CLOSE cancelCursor;

    RETURN totalCancel;
END;
$$ LANGUAGE plpgsql;
