SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE FUNCTION [Meta].[fnGetClassFields](@ClassID INT)
RETURNS VARCHAR(8000)
AS
BEGIN
  RETURN
    (
      SELECT
          STRING_AGG(c.Name, ', ')
      FROM sys.columns c
        INNER JOIN sys.tables t
          ON c.object_id = t.object_id
        INNER JOIN Meta.TClass m
          ON t.Name = m.Name
      WHERE m.ID = @ClassID
      );
END;
GO