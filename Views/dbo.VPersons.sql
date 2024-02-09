SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE   VIEW [dbo].[VPersons] AS SELECT pv.*,  t.FirstName, t.MiddleName, t.LastName FROM VObjects pv INNER JOIN TPerson t ON t.ID = pv.ID
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE TRIGGER [dbo].[trgOnPersontInsert]
ON [dbo].[VPersons]
INSTEAD OF INSERT
AS
BEGIN
  DECLARE @ID BIGINT;
  DECLARE @ClassID  INT;

  IF @@rowcount <> 1
  BEGIN
    THROW 500001, 'Cannot insert more than one object at a time', 1;
    RETURN;
  END;

  SET @ClassID = (SELECT ID FROM Meta.TClass WHERE Name = 'TPerson');

  EXEC Meta.spObjectInsert @ClassID = @ClassID, @ID = @ID OUTPUT;

  SELECT @ID AS ID, @ClassID AS ClassID, FirstName, MiddleName, LastName 
  INTO dbo.TPerson
  FROM inserted;
END;
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE TRIGGER [dbo].[trgOnPersonUpdate]
ON [dbo].[VPersons]
INSTEAD OF UPDATE
AS
BEGIN
  DECLARE @ClassID  INT;
  DECLARE @ObjectID BIGINT;
  DECLARE @EventID  TINYINT;
  DECLARE @HistoryID BIGINT;

  IF @@rowcount <> 1
  BEGIN
    THROW 500001, 'Cannot update more than one object at a time', 1;
    RETURN;
  END;

  IF UPDATE(ID) OR UPDATE(ClassID)
    THROW 500002, 'Cannot update object ID nor class ID', 1;

  SET @ClassID = (SELECT ID FROM Meta.TClass WHERE Name = 'TPerson');
  SET @ObjectID = (SELECT ID FROM inserted);
  SET @EventID  = (SELECT ID FROM Meta.TEvent WHERE Name = 'Updated');

  IF Meta.GetClassHasHistory(@ClassID) = 1
  BEGIN
    EXEC Meta.spHistoryInsert @ObjectID = @ObjectID, @EventID = @EventID, @HistoryID = @HistoryID OUTPUT;

    SELECT @HistoryID AS HID, o.*
    INTO HPersons
    FROM deleted o;
  END;

  UPDATE TPerson
  SET
    FirstName  = n.FirstName,
    MiddleName = n.MiddleName,
    LastName   = n.LastName
  FROM inserted n;

END;
GO