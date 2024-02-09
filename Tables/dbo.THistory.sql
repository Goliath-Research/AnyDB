CREATE TABLE [dbo].[THistory] (
  [ID] [bigint] IDENTITY,
  [ObjectID] [bigint] NOT NULL,
  [EventID] [tinyint] NOT NULL,
  [EventTime] [datetime] NULL DEFAULT (getdate()),
  CONSTRAINT [PK_THistory_ID] PRIMARY KEY CLUSTERED ([ID])
)
ON [PRIMARY]
GO

CREATE INDEX [IDX_THistory_ObjectID]
  ON [dbo].[THistory] ([ObjectID])
  ON [PRIMARY]
GO

ALTER TABLE [dbo].[THistory]
  ADD CONSTRAINT [FK_THistory_TEvent_ID] FOREIGN KEY ([EventID]) REFERENCES [Meta].[TEvent] ([ID])
GO

ALTER TABLE [dbo].[THistory]
  ADD CONSTRAINT [FK_THistory_TObject_ID] FOREIGN KEY ([ObjectID]) REFERENCES [dbo].[TObject] ([ID])
GO