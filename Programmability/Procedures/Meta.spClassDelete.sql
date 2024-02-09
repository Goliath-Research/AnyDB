SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
--
-- The goal of this procedure is to emulate the
-- behavior of CASCADE DELETE
--
CREATE PROCEDURE [Meta].[spClassDelete](@ClassID INT)
AS
BEGIN
  DECLARE @ChildClassID INT;

  IF @ClassID IS NULL
    RETURN;

  SET @ChildClassID = Meta.fnGetFirstChildClassID(@ClassID);

  WHILE @ChildClassID IS NOT NULL
  BEGIN
    EXEC Meta.spClassDelete @ClassID = @ChildClassID;

    SET @ChildClassID = Meta.fnGetFirstChildClassID(@ClassID);
  END;
END
GO