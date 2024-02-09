CREATE TABLE [Meta].[TOperation] (
  [ID] [int] IDENTITY,
  [Name] [varchar](64) NOT NULL,
  [ClassID] [int] NOT NULL,
  CONSTRAINT [PK_TOperation_ID] PRIMARY KEY CLUSTERED ([ID])
)
ON [PRIMARY]
GO

ALTER TABLE [Meta].[TOperation]
  ADD CONSTRAINT [FK_TOperation_TClass_ID] FOREIGN KEY ([ClassID]) REFERENCES [Meta].[TClass] ([ID]) ON DELETE CASCADE
GO