CREATE TABLE [Meta].[TClass] (
  [ID] [int] IDENTITY,
  [Name] [varchar](64) NOT NULL,
  [Description] [varchar](128) NULL,
  [HasHistory] [bit] NOT NULL DEFAULT (1),
  [ParentID] [int] NULL,
  CONSTRAINT [PK_TClass] PRIMARY KEY CLUSTERED ([ID])
)
ON [PRIMARY]
GO

ALTER TABLE [Meta].[TClass]
  ADD CONSTRAINT [FK_TClass] FOREIGN KEY ([ParentID]) REFERENCES [Meta].[TClass] ([ID])
GO