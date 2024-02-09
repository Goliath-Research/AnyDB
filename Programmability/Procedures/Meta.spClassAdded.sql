SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- The goal of this procedure is to automate the
-- creation of the recursive view by creating a
-- new view joining the parent view with the
-- inherited table (that is, all the columns from
-- the parent and the additional columns in the
-- child)
-- If the class includes the definition of the
-- properties, it is also possible to create
-- the columns and their constraints.
CREATE PROCEDURE [Meta].[spClassAdded] (@ClassID INT)
AS
BEGIN
  DECLARE @TableName VARCHAR(64);
  DECLARE @Fields VARCHAR(8000);
  DECLARE @ViewName VARCHAR(64);
  DECLARE @SqlCode NVARCHAR(4000);
  DECLARE @HasHistory BIT;
  DECLARE @HistoryTable VARCHAR(64);

  SELECT
    @TableName = Name
   ,@HasHistory = HasHistory
  FROM TClass
  WHERE ID = @ClassID;

  -- If the table is not yet created, create it!

  IF NOT EXISTS (SELECT
        *
      FROM sys.tables
      WHERE name = @TableName)
  BEGIN
    EXEC Meta.spClassCreateTableSql @ClassID = @ClassID
                                   ,@Sql = @SqlCode OUTPUT;

    EXEC sp_executesql @SqlCode;
  END;

  -- Now we can create the view

  EXEC Meta.spClassCreateViewSql @ClassID = @ClassID
                                ,@Sql = @SqlCode OUTPUT;
  EXEC sp_executesql @SqlCode;

  -- If this class will keep a history of its objects, create the history table.
  -- Its structure will be identical as the view, but adding an ID and timestamp.

  IF @HasHistory = 1
  BEGIN
    EXEC Meta.spClassCreateHistorySql @ClassID = @ClassID
                                     ,@Sql = @SqlCode OUTPUT;

    EXEC sp_executesql @SqlCode;
  END
END
GO