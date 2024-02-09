CREATE TABLE [dbo].[HPersons] (
  [HID] [bigint] NOT NULL,
  [ID] [bigint] NOT NULL,
  [ClassID] [int] NOT NULL,
  [FirstName] [varchar](64) NOT NULL,
  [MiddleName] [varchar](64) NULL,
  [LastName] [varchar](64) NOT NULL,
  CONSTRAINT [PK_HPersons_HID] PRIMARY KEY CLUSTERED ([HID])
)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[HPersons]
  ADD CONSTRAINT [FK_HPersons_THistory_ID] FOREIGN KEY ([HID]) REFERENCES [dbo].[THistory] ([ID]) ON DELETE CASCADE
GO