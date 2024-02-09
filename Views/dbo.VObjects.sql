SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE VIEW [dbo].[VObjects]
AS
SELECT
  ID
 ,ClassID
FROM dbo.TObject
WHERE ClassID = (SELECT
    ClassID
  FROM Meta.TClass
  WHERE Name = 'TObject')
GO