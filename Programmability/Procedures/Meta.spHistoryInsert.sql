SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [Meta].[spHistoryInsert](@ObjectID BIGINT, @EventID TINYINT, @HistoryID BIGINT OUTPUT)
AS 
BEGIN
	INSERT INTO dbo.THistory (ObjectID, EventID)
    VALUES (@ObjectID, @EventID);

  SET @HistoryID = (SELECT IDENT_CURRENT('THistory'));
END
GO