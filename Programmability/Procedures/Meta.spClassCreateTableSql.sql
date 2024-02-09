SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [Meta].[spClassCreateTableSql](@ClassID INT, @Sql NVARCHAR(4000) OUTPUT)
AS
BEGIN
  DECLARE @ParentClassID    INT;
  DECLARE @ParentClassName  VARCHAR(64);
  DECLARE @ParentViewName   VARCHAR(64);
  DECLARE @TableName        VARCHAR(64);
  DECLARE @ViewName         VARCHAR(64);
  DECLARE @TableFields      VARCHAR(8000);
  DECLARE @ViewFields       VARCHAR(8000);

  SET @ParentClassID   = (SELECT ParentID FROM Meta.TClass WHERE ID = @ClassID);
  SET @ParentClassName = (SELECT Name FROM Meta.TClass WHERE ID = @ParentClassID);
  SET @ParentViewName  = Meta.fnGetViewName(@ParentClassName);

  SET @TableName = (SELECT Name FROM Meta.TClass WHERE ID = @ClassID);
  SET @ViewName  = Meta.fnGetViewName(@TableName);

  SET @ViewFields = Meta.fnGetClassFields(@ClassID);
  -- Add to each field the alias of the table
  -- Delete the start of the fields (ID, )
  -- ID, FirstName, MiddleName, LastName
  SET @ViewFields  = REPLACE(', ', ', t.', @ViewFields);
  -- ID, t.FirstName, t.MiddleName, t.LastName
  SET @ViewFields  = RIGHT(@TableFields, LEN(@TableFields) - 4);
  -- t.FirstName, t.MiddleName, t.LastName

  SET @Sql = 
    'CREATE VIEW ' + @ViewName + '\n' +
    'AS\n' + 
    'SELECT pv.*, ' + @ViewFields + '\n' +
    'FROM ' + @ParentViewName + 'pv INNER JOIN ' + @TableName + ' t ON t.ID = pv.ID';
END;
GO