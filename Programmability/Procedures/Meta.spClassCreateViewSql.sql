SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [Meta].[spClassCreateViewSql](@ClassID INT, @Sql NVARCHAR(4000) OUTPUT)
AS
BEGIN
  DECLARE @ParentClassID    INT;
  DECLARE @ParentClassName  VARCHAR(64);
  DECLARE @ParentViewName   VARCHAR(64);
  DECLARE @TableName        VARCHAR(64);
  DECLARE @ViewName         VARCHAR(64);
  DECLARE @ViewFields       VARCHAR(8000);

  SET @ParentClassID   = (SELECT ParentID FROM Meta.TClass WHERE ID = @ClassID);
  SET @ParentClassName = (SELECT Name FROM Meta.TClass WHERE ID = @ParentClassID);
  SET @ParentViewName  = Meta.fnGetViewName(@ParentClassName);

  SET @TableName = (SELECT Name FROM Meta.TClass WHERE ID = @ClassID);
  SET @ViewName  = Meta.fnGetViewName(@TableName);

  SET @ViewFields = Meta.fnGetClassFields(@ClassID);
  -- Add to each field the alias of the table
  -- Delete the start of the fields (ID, )
  -- ID,FirstName,MiddleName,LastName
  SET @ViewFields  = REPLACE(@ViewFields, ', ', ', t.');
  -- ID,t.FirstName,t.MiddleName,t.LastName
  SET @ViewFields  = RIGHT(@ViewFields, LEN(@ViewFields) - 3);
  -- t.FirstName,t.MiddleName,t.LastName

  SET @Sql = 
    'CREATE VIEW ' + @ViewName + 
    ' AS ' +  
    'SELECT pv.*, ' + @ViewFields + 
    ' FROM ' + @ParentViewName + ' pv INNER JOIN ' + @TableName + ' t ON t.ID = pv.ID';
END;
GO