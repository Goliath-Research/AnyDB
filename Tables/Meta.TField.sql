CREATE TABLE [Meta].[TField] (
  [ID] [int] IDENTITY,
  [Name] [varchar](64) NOT NULL,
  [TypeID] [int] NOT NULL,
  [IsRequired] [bit] NOT NULL DEFAULT (1),
  [ClassID] [int] NOT NULL,
  [ParamValues] [varchar](512) NULL,
  CONSTRAINT [PK_TField_ID] PRIMARY KEY CLUSTERED ([ID])
)
ON [PRIMARY]
GO

ALTER TABLE [Meta].[TField]
  ADD CONSTRAINT [FK_TField_TClass_ID] FOREIGN KEY ([ClassID]) REFERENCES [Meta].[TClass] ([ID]) ON DELETE CASCADE
GO

ALTER TABLE [Meta].[TField]
  ADD CONSTRAINT [FK_TField_TType_ID] FOREIGN KEY ([TypeID]) REFERENCES [Meta].[TType] ([ID])
GO