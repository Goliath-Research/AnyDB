CREATE TABLE [Meta].[TRelationKind] (
  [ID] [tinyint] IDENTITY,
  [Name] [varchar](32) NOT NULL,
  [Owns] [bit] NOT NULL,
  CONSTRAINT [PK_TRelationKind_ID] PRIMARY KEY CLUSTERED ([ID])
)
ON [PRIMARY]
GO