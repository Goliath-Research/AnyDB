SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE FUNCTION [Meta].[fnGetFirstChildClassID] (@ClassID int)
RETURNS INT
AS
BEGIN
  DECLARE @ChildClassID INT;

  SELECT
    @ChildClassID = MIN(t.ID)
  FROM Meta.TClass t
  WHERE t.ParentID = @ClassID;

  RETURN @ChildClassID;
END
GO