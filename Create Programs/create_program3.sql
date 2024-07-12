-- Patients(patientID, patientName, address, creditCardType, creditCardNumber, expirationDate, isCardValid)
CREATE TABLE Patients (
    patientID INT PRIMARY KEY,
    patientName VARCHAR(40),
    address VARCHAR(50),
    creditCardType CHAR(1),
    creditCardNumber INT,
    expirationDate DATE,
    isCardValid BOOLEAN
);


-- Dentists(dentistID, dentistName, address, dentalSchool, graduationDate, isMemberADA)
CREATE TABLE Dentists (
    dentistID INT PRIMARY KEY,
    dentistName VARCHAR(40),
    address VARCHAR(50),
    dentalSchool VARCHAR(40),
    graduationDate DATE,
    isMemberADA BOOLEAN
);


-- Teeth(toothNumber, toothName, quadrant)
CREATE TABLE Teeth (
    toothNumber INT PRIMARY KEY,
    toothName CHAR(18),
    quadrant CHAR(2)
);


-- Visits(patientID, dentistID, visitStartTimestamp, visitDuration)
CREATE TABLE Visits (
    patientID INT REFERENCES Patients,
    dentistID INT REFERENCES Dentists,
    visitStartTimestamp TIMESTAMP,
    visitDuration INTERVAL,
    PRIMARY KEY (patientID, dentistID, visitStartTimestamp)
);


-- DentalTreatments(treatmentType, treatmentDuration, treatmentFee)
CREATE TABLE DentalTreatments (
    treatmentType CHAR(12) PRIMARY KEY,
    treatmentDuration INTERVAL,
    treatmentFee NUMERIC(5,2)
);


-- TreatmentsDuringVisits(patientID, dentistID, visitStartTimestamp, toothNumber, treatmentType, wasPaymentReceived)
CREATE TABLE TreatmentsDuringVisits (
    patientID INT,
    dentistID INT,
    visitStartTimestamp TIMESTAMP,
    toothNumber INT REFERENCES Teeth,
    treatmentType CHAR(12) REFERENCES DentalTreatments,
    wasPaymentReceived BOOLEAN,
    PRIMARY KEY (patientID, dentistID, visitStartTimestamp, toothNumber, treatmentType),
    FOREIGN KEY (patientID, dentistID, visitStartTimestamp) REFERENCES Visits
	ON DELETE CASCADE
);
