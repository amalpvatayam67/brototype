
# AWS Hands-On Lab: Serverless Computing with AWS Lambda & Data Querying with Amazon Athena

## Objective
This lab focuses on:
- Understanding AWS Lambda for serverless application development
- Creating a Lambda function to automate a simple task
- Using Amazon Athena to query data stored in Amazon S3
- Documenting queries, processes, and outcomes

---

## A. Understanding AWS Lambda (Serverless Computing)

### What is AWS Lambda?
AWS Lambda is a **serverless compute service** that allows you to run code without provisioning or managing servers.

### Key Features:
- Event-driven execution
- Automatic scaling
- Pay only for execution time
- Supports multiple runtimes (Python, Node.js, Java, Go)

### Common Use Cases:
- Data processing
- Log analysis
- Automation tasks
- API backends

---

## B. Create a Lambda Function to Automate a Task

### Use Case Example:
**Automated S3 File Processing & Notification**

### Steps:
1. Open **AWS Management Console → Lambda**
2. Click **Create Function**
3. Choose:
   - Author from scratch
   - Function name: `s3-file-processor`
   - Runtime: Python 3.x
4. Create or assign an IAM role with:
   - `AWSLambdaBasicExecutionRole`
   - `AmazonS3ReadOnlyAccess`
5. Create function

---

### Sample Lambda Function (Python)

```python
def lambda_handler(event, context):
    print("Lambda triggered successfully")
    return {
        'statusCode': 200,
        'body': 'Task executed successfully'
    }
```

### Testing:
1. Create a test event
2. Execute the function
3. Verify logs in **CloudWatch**

---

## C. Using Amazon Athena to Query Data from S3

### What is Amazon Athena?
Amazon Athena is a **serverless interactive query service** that uses standard SQL to analyze data stored in S3.

### Supported Data Formats:
- CSV
- JSON
- Parquet
- ORC

---

### Setup Steps:
1. Upload sample CSV/JSON file to S3 bucket
2. Navigate to **Amazon Athena**
3. Configure query result location:
   - Example: `s3://athena-query-results-bucket/`
4. Create a database:

```sql
CREATE DATABASE sample_db;
```

5. Create a table:

```sql
CREATE EXTERNAL TABLE sample_db.users (
  id INT,
  name STRING,
  email STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
WITH SERDEPROPERTIES (
  'serialization.format' = ',',
  'field.delim' = ','
)
LOCATION 's3://my-data-bucket/users/';
```

---

## D. Athena Queries and Outcomes

### Query 1: View All Records
```sql
SELECT * FROM sample_db.users;
```

### Query 2: Filter Data
```sql
SELECT name, email FROM sample_db.users WHERE id > 10;
```

### Query 3: Count Records
```sql
SELECT COUNT(*) FROM sample_db.users;
```

---

## Outcomes:
- Athena successfully queried data directly from S3
- No servers or databases were required
- Queries executed using standard SQL
- Results available in S3 and Athena console

---

## Architecture Flow

1. Data stored in S3
2. Lambda processes or reacts to events
3. Athena queries S3 data using SQL
4. IAM controls access and permissions
5. CloudWatch logs Lambda executions

---

## Security & Best Practices
- Use least-privilege IAM roles for Lambda and Athena
- Encrypt S3 data at rest
- Monitor Lambda logs in CloudWatch
- Optimize Athena queries using columnar formats (Parquet)

---

## Conclusion
This lab demonstrates how AWS Lambda enables serverless automation while Amazon Athena provides powerful, cost-effective data querying directly on S3. Together, they form a scalable and efficient cloud-native data processing workflow.
