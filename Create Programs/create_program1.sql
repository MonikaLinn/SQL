CREATE TABLE Patients(
patientID INT,
patientName VARCHAR(40),
address VARCHAR(50),
creditCardType CHAR(1),
creditCardNumber INT,
expirationDate DATE,
isCardValid BOOLEAN,
PRIMARY KEY (patientID)
);

CREATE TABLE Dentists(
dentistID INT,
dentistName VARCHAR(40),
address VARCHAR(50),
dentalSchool VARCHAR(40),
graduationDate DATE,
isMemberADA BOOLEAN,
PRIMARY KEY (dentistID)
);

CREATE TABLE Teeth(
toothNumber INT,
toothName CHAR(12),
quadrant CHAR(2),
PRIMARY KEY (toothNumber)
);

CREATE TABLE Visits(
patientID INT,
dentistID INT,
visitStartTimestamp TIMESTAMP,
visitDuration INTERVAL,
PRIMARY KEY (patientID, dentistID, visitStartTimestamp),
FOREIGN KEY (patientID) REFERENCES Patients,
FOREIGN KEY (dentistID) REFERENCES Dentists
);

CREATE TABLE DentalTreatments (
treatmentType CHAR(12),
treatmentDuration INTERVAL,
treatmentFee NUMERIC(5,2),
PRIMARY KEY (treatmentType)
);

CREATE TABLE TreatmentsDuringVisits(
patientID INT,
dentistID INT,
visitStartTimestamp TIMESTAMP,
toothNumber INT,
treatmentType CHAR(12),
wasPaymentReceived BOOLEAN,
PRIMARY KEY (patientID, dentistID, visitStartTimestamp, toothNumber, treatmentType),
FOREIGN KEY (patientID, dentistID, visitStartTimestamp) REFERENCES Visits(patientID, dentistID, visitStartTimestamp),
FOREIGN KEY (toothNumber) REFERENCES Teeth,
FOREIGN KEY (treatmentType) REFERENCES DentalTreatments
);