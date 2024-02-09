CREATE TABLE [Meta].[TEvent] (
  [ID] [tinyint] IDENTITY,
  [Name] [varchar](32) NOT NULL,
  CONSTRAINT [PK_TEvent_ID] PRIMARY KEY CLUSTERED ([ID])
)
ON [PRIMARY]
GO