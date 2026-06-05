# DATA FUNDAMENTALS
Data is simply raw facts and figures, without context, data is useless.
Example of using data:
- Weather app > Collects data around weather, temperature, humidity, location, and time then presents it to you to use.
- Bank app > Collects data on bank deposits, transactions, payments to help you track your money.

#### DATA CATEGORY
- Structured Data: In tabular formats (rows and columns).
- Semi Structured Data: A format that is in the middle, which is not stored in a rigid table form, but still has labels or separators.
- Unstructured Data: Data without a special format such as article text, images, video, or audio.
  
#### KPI VS METRICS
Once data is structured and categorized, a Data Analyst uses it to measure business performance. This is where KPIs and Metrics come into play to turn raw data into actionable insights. 
While both track performance, they serve different purposes:
- KPIs (Key Performance Indicators) show the big picture of whether we are successfully reaching our critical business goals.
- Metrics track day-to-day activities and help us understand the smaller details of what is happening within our data to support those KPIs.

*In short: All KPIs are metrics, but not all metrics are KPIs.*

#### DATA TYPES
- A data type is an attribute associated with a piece of data that tells a computer system how to interpret its value.
- Every programming language and database has similar, but slightly different data types.

There are 3 main data types:
- Strings (like free text) ex. Names: "John Smith", "Emma Johnson"
- Numbers
- Date/Time

#### FILE TYPES
- File types refer to the format in which data is stored in a file.
- Each file type is designed for specific purposes, depending on the kind of data it holds and how it will be processed or shared.
- File types are like containers, each designed for a specific use case.

There are several types based on how they store data:

- Text File Types: Simple files that store data as plain text, often used for unformatted or tabular data. Common formats: .txt and .csv
- Structured File Types: Store data in a predefined structure, often organized in rows and columns or hierarchical formats. Common formats: .xlsx and .db
- Semi-Structured File Types: Files that have a loose structure, often used to store complex data relationships. Common formats: .json and .xml
- Unstructured File Types: Files that do not follow a specific format, often containing raw data or multimedia content. Common formats: .png and .mp4
- Big Data and Specialized File Types: These file types are designed for handling large-scale data efficiently. Common format: .parquet

#### DATA COLLECTION
The process of gathering data from various sources to use in analysis, decision making, and problem solving.
Sources can be: Hospital EHRs, Bank Accounts, APIs, Websites, CSV Files.

Data collection is important because:

- It ensures you have the raw material needed to make informed decisions.
- It helps you identify trends, patterns, and opportunities.
- It lays the foundation for data quality, poor collection leads to inaccurate results.

#### DATA PIPELINE
System that automates the movement of data from one place to another while often transforming it along the way.

**ETL Pipeline (Extact, Transform, Load)**

An ETL Pipeline is the process used to move data from raw sources to a final destination (Data Warehouse).
- Extract: Pulling raw data from various sources (Source 1, Source 2, Source 3, etc).
- Transform: Cleaning and processing the raw data in a staging area to convert it into a structured, prepared format.
- Load: Moving the prepared and cleaned data into a Data Warehouse.

Once the data is successfully loaded into the Data Warehouse, it is ready for the analysis stage. At this stage, the data is queried to find trends, build dashboards, and generate actionable insights.

#### DATA CLEANING
Process of identifying and fixing issues (dirty data) to ensure it's accurate, consistent, and complete.

We need to clean data because:

- It ensures accuracy: Decisions based on bad data can lead to costly mistakes.
- It improves efficiency: Clean data is easier to analyze and saves time.
- It builds trust: Stakeholders need confidence in data to act on insights.

Data Cleaning Cycle 
The process of cleaning data typically follows a continuous cycle to ensure data quality from start to finish. This cycle involves several key steps:

- Importing data
- Merging data sets
- Rebuilding missing data
- Standardization
- Normalization
- De-duplication
- Verification & enrichment
- Exporting data

*Note: This cycle isn't actually that rigid, just perform the steps based on current needs. However, it is the one most commonly practiced.*
