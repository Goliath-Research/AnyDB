CREATE TABLE [dbo].[TPerson] (
  [ID] [bigint] NOT NULL,
  [FirstName] [varchar](64) NOT NULL,
  [MiddleName] [varchar](64) NULL,
  [LastName] [varchar](64) NOT NULL,
  CONSTRAINT [PK_TPerson_ID] PRIMARY KEY CLUSTERED ([ID])
)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[TPerson]
  ADD CONSTRAINT [FK_TPerson_TObject_ID] FOREIGN KEY ([ID]) REFERENCES [dbo].[TObject] ([ID]) ON DELETE CASCADE
GO