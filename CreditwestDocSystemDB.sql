CREATE TABLE [dbo].[Active] (
    [ActiveID]   INT              NOT NULL,
    [DocumentID] UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY CLUSTERED ([ActiveID] ASC),
    CONSTRAINT [FK_Active_Document] FOREIGN KEY ([DocumentID]) REFERENCES [dbo].[Document] ([DocumentID])
);

CREATE TABLE [dbo].[Cancelled] (
    [CancelledID] INT              NOT NULL,
    [DocumentID]  UNIQUEIDENTIFIER NOT NULL,
    [Feedback]    NVARCHAR (MAX)   NOT NULL,
    PRIMARY KEY CLUSTERED ([CancelledID] ASC),
    CONSTRAINT [FK_Cancelled_Document] FOREIGN KEY ([DocumentID]) REFERENCES [dbo].[Document] ([DocumentID])
);

CREATE TABLE [dbo].[CompletedFeedback] (
    [CompFeedID] INT NOT NULL,
    [FeedbackID] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([CompFeedID] ASC),
    CONSTRAINT [FK_CompletedFeedback_Feedback] FOREIGN KEY ([FeedbackID]) REFERENCES [dbo].[Feedback] ([FeedbackID])
);

CREATE TABLE [dbo].[ConfirmedSignatures] (
    [ConfirmedSignatureID] INT              NOT NULL,
    [DocumentID]           UNIQUEIDENTIFIER NOT NULL,
    [UserID]               UNIQUEIDENTIFIER NOT NULL,
    [SignDate]             DATETIME         NOT NULL,
    PRIMARY KEY CLUSTERED ([ConfirmedSignatureID] ASC),
    CONSTRAINT [FK_ConfirmedSignatures_Document] FOREIGN KEY ([DocumentID]) REFERENCES [dbo].[Document] ([DocumentID])
);

CREATE TABLE [dbo].[Deleted] (
    [DeletedID]  INT              NOT NULL,
    [DocumentID] UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY CLUSTERED ([DeletedID] ASC),
    CONSTRAINT [FK_Deleted_Document] FOREIGN KEY ([DocumentID]) REFERENCES [dbo].[Document] ([DocumentID])
);

CREATE TABLE [dbo].[Dependency] (
    [DependID]    INT              NOT NULL,
    [DocumentID1] UNIQUEIDENTIFIER NOT NULL,
    [DocumentID2] UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY CLUSTERED ([DependID] ASC),
    CONSTRAINT [FK_Dependency_Document_D1] FOREIGN KEY ([DocumentID1]) REFERENCES [dbo].[Document] ([DocumentID]),
    CONSTRAINT [FK_Dependency_Document_D2] FOREIGN KEY ([DocumentID2]) REFERENCES [dbo].[Document] ([DocumentID])
);

CREATE TABLE [dbo].[Document] (
    [DocumentID]       UNIQUEIDENTIFIER NOT NULL,
    [Title]            NVARCHAR (MAX)   NOT NULL,
    [Content]          NVARCHAR (MAX)   NOT NULL,
    [FilePath]         NVARCHAR (MAX)   NOT NULL,
    [PublisherID]      UNIQUEIDENTIFIER NOT NULL,
    [PublishDate]      DATETIME         NOT NULL,
    [SystemUpdateDate] DATETIME2 (7)    NOT NULL,
    [ReferenceNumber]  NVARCHAR (50)    NOT NULL,
    [isSigned]         BIT              NOT NULL,
    PRIMARY KEY CLUSTERED ([DocumentID] ASC)
);


CREATE TABLE [dbo].[EndDate] (
    [EndDateID]      INT              NOT NULL,
    [DocumentID]     UNIQUEIDENTIFIER NOT NULL,
    [ExpirationDate] DATETIME         NULL,
    PRIMARY KEY CLUSTERED ([EndDateID] ASC),
    CONSTRAINT [FK_EndDate_Document] FOREIGN KEY ([DocumentID]) REFERENCES [dbo].[Document] ([DocumentID])
);

CREATE TABLE [dbo].[Feedback] (
    [FeedbackID]   INT              NOT NULL,
    [UserID]       UNIQUEIDENTIFIER NOT NULL,
    [DocumentID]   UNIQUEIDENTIFIER NOT NULL,
    [Comment]      NVARCHAR (MAX)   NOT NULL,
    [SendDate]     DATETIME         NULL,
    [EndDate]      DATETIME         NULL,
    [ResponseDate] DATETIME         NULL,
    PRIMARY KEY CLUSTERED ([FeedbackID] ASC),
    CONSTRAINT [FK_Feedback_Document] FOREIGN KEY ([DocumentID]) REFERENCES [dbo].[Document] ([DocumentID])
);

CREATE TABLE [dbo].[FileRevisions] (
    [FileReID]       INT           NOT NULL,
    [FileType]       NVARCHAR (50) NOT NULL,
    [SequenceNumber] INT           NOT NULL,
    [RevisionNumber] INT           NULL,
    PRIMARY KEY CLUSTERED ([FileReID] ASC)
);

CREATE TABLE [dbo].[FileSequence] (
    [FileSeqID]      INT        NOT NULL,
    [FileType]       NCHAR (10) NOT NULL,
    [SequenceNumber] INT        NOT NULL,
    PRIMARY KEY CLUSTERED ([FileSeqID] ASC)
);

CREATE TABLE [dbo].[IncompletedFeedback] (
    [IncFeedID]  INT NOT NULL,
    [FeedbackID] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([IncFeedID] ASC),
    CONSTRAINT [FK_IncompletedFeedback_Feedback] FOREIGN KEY ([FeedbackID]) REFERENCES [dbo].[Feedback] ([FeedbackID])
);

CREATE TABLE [dbo].[LinkRolePermission] (
    [LinkRolePermissonID] INT IDENTITY (1, 1) NOT NULL,
    [RoleID]              INT NOT NULL,
    [PermissionID]        INT NOT NULL,
    PRIMARY KEY CLUSTERED ([LinkRolePermissonID] ASC),
    CONSTRAINT [Role_ID] FOREIGN KEY ([RoleID]) REFERENCES [dbo].[Role] ([RoleID]),
    CONSTRAINT [Permission_ID] FOREIGN KEY ([PermissionID]) REFERENCES [dbo].[Permission] ([PermissionID])
);


CREATE TABLE [dbo].[LinkUserFile] (
    [LinkUserFileID] INT              NOT NULL,
    [UserID]         UNIQUEIDENTIFIER NOT NULL,
    [DocumentID]     UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY CLUSTERED ([LinkUserFileID] ASC),
    CONSTRAINT [FK_LinkUserFile_Document] FOREIGN KEY ([DocumentID]) REFERENCES [dbo].[Document] ([DocumentID])
);

CREATE TABLE [dbo].[LinkUserRole] (
    [LurID]  INT              NOT NULL,
    [UserID] UNIQUEIDENTIFIER NOT NULL,
    [RoleID] INT              NOT NULL,
    PRIMARY KEY CLUSTERED ([LurID] ASC),
    CONSTRAINT [FK_LinkUserRole_Role] FOREIGN KEY ([RoleID]) REFERENCES [dbo].[Role] ([RoleID])
);

CREATE TABLE [dbo].[Permission] (
    [PermissionID]   INT           NOT NULL,
    [PermissionName] NVARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([PermissionID] ASC)
);

CREATE TABLE [dbo].[PostCheck] (
    [PostID]     INT              NOT NULL,
    [DocumentID] UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY CLUSTERED ([PostID] ASC),
    CONSTRAINT [FK_PostCheck_Document] FOREIGN KEY ([DocumentID]) REFERENCES [dbo].[Document] ([DocumentID])
);

CREATE TABLE [dbo].[PreCheck] (
    [PrecheckID]     INT              NOT NULL,
    [DocumentID]     UNIQUEIDENTIFIER NOT NULL,
    [SignatureCount] INT              NOT NULL,
    PRIMARY KEY CLUSTERED ([PrecheckID] ASC),
    CONSTRAINT [FK_PreCheck_Document] FOREIGN KEY ([DocumentID]) REFERENCES [dbo].[Document] ([DocumentID])
);

CREATE TABLE [dbo].[QueuedSignatures] (
    [QueuedSignatureID] INT              NOT NULL,
    [DocumentID]        UNIQUEIDENTIFIER NOT NULL,
    [UserID]            UNIQUEIDENTIFIER NOT NULL,
    [LineNumber]        INT              NULL,
    PRIMARY KEY CLUSTERED ([QueuedSignatureID] ASC),
    CONSTRAINT [FK_QueuedSignatures_Document] FOREIGN KEY ([DocumentID]) REFERENCES [dbo].[Document] ([DocumentID])
);

CREATE TABLE [dbo].[Revised] (
    [RevisedID]  INT              NOT NULL,
    [DocumentID] UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY CLUSTERED ([RevisedID] ASC),
    CONSTRAINT [FK_Revised_Document] FOREIGN KEY ([DocumentID]) REFERENCES [dbo].[Document] ([DocumentID])
);

CREATE TABLE [dbo].[Role] (
    [RoleID]   INT            NOT NULL,
    [RoleName] NVARCHAR (MAX) NOT NULL,
    PRIMARY KEY CLUSTERED ([RoleID] ASC)
);

CREATE TABLE [dbo].[SubFileRevisions] (
    [SubFileRevID]    INT        NOT NULL,
    [FileType]        NCHAR (10) NOT NULL,
    [SequenceNumber]  INT        NOT NULL,
    [SubFileType]     NCHAR (10) NOT NULL,
    [SubFileSequence] INT        NOT NULL,
    [RevisionNumber]  INT        NULL,
    PRIMARY KEY CLUSTERED ([SubFileRevID] ASC)
);

CREATE TABLE [dbo].[SubFileSequence] (
    [SubFileSeqID]          INT        NOT NULL,
    [FileType]              NCHAR (10) NOT NULL,
    [SequenceNumber]        INT        NOT NULL,
    [SubFileType]           NCHAR (10) NOT NULL,
    [SubFileSequenceNumber] INT        NOT NULL,
    PRIMARY KEY CLUSTERED ([SubFileSeqID] ASC)
);

CREATE TABLE [dbo].[ValidDate] (
    [ValidDateID]    INT              NOT NULL,
    [DocumentID]     UNIQUEIDENTIFIER NOT NULL,
    [ValidationDate] DATETIME         NOT NULL,
    PRIMARY KEY CLUSTERED ([ValidDateID] ASC),
    CONSTRAINT [FK_ValidDate_Document] FOREIGN KEY ([DocumentID]) REFERENCES [dbo].[Document] ([DocumentID])
);

CREATE TABLE [dbo].[WaitingForFeedback] (
    [WFFID]      INT              NOT NULL,
    [DocumentID] UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY CLUSTERED ([WFFID] ASC),
    CONSTRAINT [FK_WaitingForFeedback_Document] FOREIGN KEY ([DocumentID]) REFERENCES [dbo].[Document] ([DocumentID])
);

CREATE TABLE [dbo].[WaitingSignatures] (
    [WaitingSignatureID] INT              NOT NULL,
    [DocumentID]         UNIQUEIDENTIFIER NOT NULL,
    [UserID]             UNIQUEIDENTIFIER NOT NULL,
    [LineNumber]         INT              NULL,
    PRIMARY KEY CLUSTERED ([WaitingSignatureID] ASC),
    CONSTRAINT [FK_WaitingSignatures_Document] FOREIGN KEY ([DocumentID]) REFERENCES [dbo].[Document] ([DocumentID])
);

CREATE TABLE [dbo].[WaitSignature] (
    [WaitSignID]     INT              NOT NULL,
    [DocumentID]     UNIQUEIDENTIFIER NOT NULL,
    [SignatureCount] INT              NULL,
    PRIMARY KEY CLUSTERED ([WaitSignID] ASC),
    CONSTRAINT [FK_WaitSignature_Document] FOREIGN KEY ([DocumentID]) REFERENCES [dbo].[Document] ([DocumentID])
);
