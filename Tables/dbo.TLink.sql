CREATE TABLE [dbo].[TLink] (
  [RelationID] [int] NOT NULL,
  [ObjectID1] [bigint] NOT NULL,
  [ObjectID2] [bigint] NOT NULL,
  [Idx] [int] NULL,
  CONSTRAINT [PK_TLink] PRIMARY KEY CLUSTERED ([RelationID], [ObjectID1], [ObjectID2])
)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[TLink]
  ADD CONSTRAINT [FK_TLink_TObject1_ID] FOREIGN KEY ([ObjectID1]) REFERENCES [dbo].[TObject] ([ID])
GO

ALTER TABLE [dbo].[TLink]
  ADD CONSTRAINT [FK_TLink_TObject2_ID] FOREIGN KEY ([ObjectID2]) REFERENCES [dbo].[TObject] ([ID])
GO

ALTER TABLE [dbo].[TLink]
  ADD CONSTRAINT [FK_TLink_TRelation_ID] FOREIGN KEY ([RelationID]) REFERENCES [Meta].[TRelation] ([ID])
GO