ALTER TABLE Visits 
ADD CONSTRAINT visitDurationPositive 
CHECK (visitDuration > INTERVAL '0 minutes');

ALTER TABLE Teeth   
ADD CONSTRAINT validToothQuadrant 
CHECK (quadrant IN ('TR', 'BR', 'TL', 'BL'));

ALTER TABLE Patients
ADD CONSTRAINT ifNullTypeThenNullNumber 
CHECK ((creditCardType is NULL and creditCardNumber is NULL) or (creditCardType is not NULL));