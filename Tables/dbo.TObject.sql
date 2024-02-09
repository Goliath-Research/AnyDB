CREATE TABLE [dbo].[TObject] (
  [ID] [bigint] IDENTITY,
  [ClassID] [int] NOT NULL,
  CONSTRAINT [PK_TObject_ID] PRIMARY KEY CLUSTERED ([ID])
)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[TObject]
  ADD CONSTRAINT [FK_TObject_TClass_ID] FOREIGN KEY ([ClassID]) REFERENCES [Meta].[TClass] ([ID]) ON DELETE CASCADE
GO