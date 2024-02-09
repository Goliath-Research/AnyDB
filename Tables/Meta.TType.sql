CREATE TABLE [Meta].[TType] (
  [ID] [int] IDENTITY,
  [Name] [varchar](32) NOT NULL,
  [Params] [varchar](256) NULL,
  CONSTRAINT [PK_TType_ID] PRIMARY KEY CLUSTERED ([ID])
)
ON [PRIMARY]
GO