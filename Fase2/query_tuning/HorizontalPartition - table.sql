CREATE TABLE EmployeeReportsD
(
ReportID int IDENTITY (1,1) NOT NULL,
ReportName varchar (100),
ReportNumber varchar (20),
ReportDate DATE,
CONSTRAINT EReportD_PK PRIMARY KEY CLUSTERED (ReportID)
)

ALTER DATABASE PartitionTestDB
ADD FILEGROUP January
GO
ALTER DATABASE PartitionTestDB
ADD FILEGROUP February
GO
ALTER DATABASE PartitionTestDB
ADD FILEGROUP March
GO
ALTER DATABASE PartitionTestDB
ADD FILEGROUP April
GO
ALTER DATABASE PartitionTestDB
ADD FILEGROUP May
GO
ALTER DATABASE PartitionTestDB
ADD FILEGROUP June
GO
ALTER DATABASE PartitionTestDB
ADD FILEGROUP July
GO
ALTER DATABASE PartitionTestDB
ADD FILEGROUP Avgust
GO
ALTER DATABASE PartitionTestDB
ADD FILEGROUP September
GO
ALTER DATABASE PartitionTestDB
ADD FILEGROUP October
GO
ALTER DATABASE PartitionTestDB
ADD FILEGROUP November
GO
ALTER DATABASE PartitionTestDB
ADD FILEGROUP December
GO

SELECT name AS AvailableFilegroups
FROM sys.filegroups
WHERE type = 'FG'