SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [Meta].[spClassCreateHistorySql] (@ClassID INT, @Sql NVARCHAR(4000) OUTPUT)
AS
BEGIN
  DECLARE @ViewName VARCHAR(64);
  DECLARE @TableName VARCHAR(64);

  SET @TableName = (SELECT
      Name
    FROM Meta.TClass
    WHERE ID = @ClassID);
  SET @ViewName = Meta.fnGetViewName(@TableName);
  SET @TableName = 'H' + RIGHT(@ViewName, LEN(@ViewName) - 1);

  SET @Sql =
    'SELECT CAST(1 AS BIGINT) AS HID, *' + CHAR(13) +
    'INTO ' + @TableName + CHAR(13) +
    'FROM ' + @ViewName;

  EXEC SP_EXECUTESQL @Sql;

  SET @Sql =
    'ALTER TABLE ' + @TableName + CHAR(13) +
    'ALTER COLUMN HID bigint NOT NULL';

  EXEC SP_EXECUTESQL @Sql;

  SET @Sql =
    'ALTER TABLE ' + @TableName + CHAR(13) +
    'ADD CONSTRAINT PK_' + @TableName + '_HID PRIMARY KEY CLUSTERED (HID)';

  EXEC SP_EXECUTESQL @Sql;

  SET @Sql =
    'ALTER TABLE ' + @TableName + CHAR(13) +
    'ADD CONSTRAINT FK_' + @TableName + '_THistory_ID FOREIGN KEY (HID) REFERENCES dbo.THistory (ID) ON DELETE CASCADE';

  EXEC SP_EXECUTESQL @Sql;
END;
GO