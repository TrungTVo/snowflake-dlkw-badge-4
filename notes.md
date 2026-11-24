## Internal vs External Stage

```
INTERNAL STAGE
==============

Local Files / Workspace
          |
          | PUT / COPY FILES
          v
   Internal Stage
   (Snowflake Storage)
          |
          | COPY INTO
          v
    Snowflake Table


EXTERNAL STAGE
==============

Spark / Glue / Applications
          |
          | Upload
          v
     Amazon S3
          |
          | Read via Storage Integration
          v
    External Stage
    (S3 reference)
          |
          | COPY INTO
          v
    Snowflake Table
```

**Internal**: Files are uploaded into Snowflake-managed stage storage before loading.

**External**: Files stay in your cloud storage, and Snowflake reads them from there when loading.