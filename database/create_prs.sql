USE master;
GO

-- Needs a drop if exists so that you can recreate this by just executing the script

CREATE DATABASE PRS;

USE PRS;
GO

CREATE TABLE Users(
Id				INT					IDENTITY PRIMARY KEY NOT NULL,
Username		NVARCHAR(30)		NOT NULL,
Password		NVARCHAR(30)		NOT NULL,
Firstname		NVARCHAR(30)		NOT NULL,
Lastname		NVARCHAR(30)		NOT NULL,
Phone			VARCHAR(12)			NULL,
Email			VARCHAR(255)		NULL,
IsReviewer		BIT					NOT NULL,
IsAdmin			BIT					NOT NULL,
);

CREATE TABLE Vendors(
Id				INT					IDENTITY PRIMARY KEY NOT NULL,
Code			VARCHAR(30)			UNIQUE NOT NULL,
Name			VARCHAR(30)			NOT NULL,
Address			VARCHAR(30)			NOT NULL,
City			VARCHAR(30)			NOT NULL,
State			VARCHAR(2)			NOT NULL,
Zip				VARCHAR(5)			NOT NULL,
Phone			VARCHAR(12)			NULL,
Email			VARCHAR(255)		NULL,
);

CREATE TABLE Products(
Id				INT					IDENTITY PRIMARY KEY NOT NULL,
PartNbr			VARCHAR(30)			UNIQUE NOT NULL,
Name			VARCHAR(30)			NOT NULL,
Price			DECIMAL(11,2)		NOT NULL,
Unit			VARCHAR(30)			NOT NULL,
PhotoPath		VARCHAR(255)		NULL,
VendorId		INT					REFERENCES Vendors(Id) NOT NULL,
);

CREATE TABLE Requests(
Id				INT					 IDENTITY PRIMARY KEY NOT NULL,
Description		VARCHAR(80)			 NOT NULL,
Justification	VARCHAR(80)			 NOT NULL,
RejectionReason	VARCHAR(80)			 NULL,
DeliveryMode	VARCHAR(20)			 NOT NULL DEFAULT 'Pickup',
SubmittedDate	DATE				 NOT NULL DEFAULT GETDATE(),
DateNeeded		DATE				 NOT NULL,
Status			VARCHAR(10)			 NOT NULL DEFAULT 'NEW',
Total			DECIMAL(11,2)		 NOT NULL DEFAULT 0,
UserId			INT					 NOT NULL REFERENCES Users(Id)
);

CREATE TABLE RequestLines(
Id			INT						 IDENTITY PRIMARY KEY NOT NULL,
RequestId	INT						 REFERENCES Requests(Id) NOT NULL,
ProductId	INT						 REFERENCES Products(Id) NOT NULL,
Quantity	INT						 NOT NULL DEFAULT 1
);

