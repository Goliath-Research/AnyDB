SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE VIEW [dbo].[VActiveObjects] 
AS WITH DeletedObjects
AS
(SELECT
    t.ObjectID
  FROM dbo.THistory t
  WHERE t.EventID = 3)
SELECT
  o.ID
 ,o.ClassID
FROM dbo.TObject o
WHERE o.ID NOT IN (SELECT
    ObjectID
  FROM DeletedObjects)
GO