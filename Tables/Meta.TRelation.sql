CREATE TABLE [Meta].[TRelation] (
  [ID] [int] IDENTITY,
  [Name] [varchar](64) NOT NULL,
  [Class1ID] [int] NOT NULL,
  [Class2ID] [int] NOT NULL,
  [RelationKindID] [tinyint] NOT NULL,
  [MinIdx2] [int] NULL,
  [MaxIdx2] [int] NULL,
  [Indexed] [bit] NULL DEFAULT (0),
  CONSTRAINT [PK_TRelation_ID] PRIMARY KEY CLUSTERED ([ID]),
  CONSTRAINT [CK_TRelation_Cardinality] CHECK ([MinIdx2] IS NULL OR [MaxIdx2] IS NULL OR [MinIdx2]<=[MaxIdx2])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [UK_TRelation]
  ON [Meta].[TRelation] ([Name], [Class1ID], [Class2ID])
  ON [PRIMARY]
GO

ALTER TABLE [Meta].[TRelation]
  ADD CONSTRAINT [FK_TRelation_TClass1_ID] FOREIGN KEY ([Class1ID]) REFERENCES [Meta].[TClass] ([ID])
GO

ALTER TABLE [Meta].[TRelation]
  ADD CONSTRAINT [FK_TRelation_TClass2_ID] FOREIGN KEY ([Class2ID]) REFERENCES [Meta].[TClass] ([ID])
GO

ALTER TABLE [Meta].[TRelation]
  ADD CONSTRAINT [FK_TRelation_TRelationKind_ID] FOREIGN KEY ([RelationKindID]) REFERENCES [Meta].[TRelationKind] ([ID]) ON DELETE CASCADE
GO