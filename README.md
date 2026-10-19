# JSP CRUD Assignment

This project contains two JSP-based applications demonstrating CRUD (Create, Read, Update, Delete) operations:
1. Employee Management System
2. Patient Record Management System

## Prerequisites

1. **Apache Tomcat 9** - Make sure Tomcat is installed and running
2. **MySQL Server** - Make sure MySQL is installed and running
3. **MySQL Connector/J** - The JDBC driver for MySQL must be in Tomcat's lib directory

## Setup Instructions

### 1. Database Setup
1. Start MySQL server
2. Create the database and tables using the provided SQL script:
   ```bash
   mysql -u root -p < database.sql
   ```
   Or execute the SQL statements in MySQL Workbench or any MySQL client.

### 2. Tomcat Configuration
1. Copy the MySQL Connector/J JAR file to Tomcat's lib directory:
   ```
   Copy mysql-connector-j-X.X.X.jar to 
   D:\3rd SEM\JAVA\apache-tomcat-9.0.123-windows-x64\apache-tomcat-9.0.123\lib\
   ```
2. If you don't have the MySQL Connector/J, download it from:
   https://dev.mysql.com/downloads/connector/j/

### 3. Deploy Applications
1. Copy the EmployeeCRUD folder to Tomcat's webapps directory:
   ```
   Copy JSP_CRUD_Assignment\EmployeeCRUD to
   D:\3rd SEM\JAVA\apache-tomcat-9.0.123-windows-x64\apache-tomcat-9.0.123\webapps\
   ```
2. Copy the PatientCRUD folder to Tomcat's webapps directory:
   ```
   Copy JSP_CRUD_Assignment\PatientCRUD to
   D:\3rd SEM\JAVA\apache-tomcat-9.0.123-windows-x64\apache-tomcat-9.0.123\webapps\
   ```

### 4. Configure Database Credentials
1. Edit the `dbConnection.jsp` file in both EmployeeCRUD and PatientCRUD directories
2. Update the MySQL username and password:
   ```java
   String connectionUser = "your_mysql_username";
   String connectionPassword = "your_mysql_password";
   ```

### 5. Start Tomcat
1. Navigate to Tomcat's bin directory:
   ```
   D:\3rd SEM\JAVA\apache-tomcat-9.0.123-windows-x64\apache-tomcat-9.0.123\bin
   ```
2. Run startup.bat (Windows) or startup.sh (Linux/Mac):
   ```
   startup.bat
   ```

### 6. Access the Applications
Once Tomcat is running, access the applications at:

- Employee Management System: http://localhost:8080/EmployeeCRUD/
- Patient Record Management System: http://localhost:8080/PatientCRUD/

## Features

### Employee Management System
- Add new employee records with name, department, and salary
- View all employee records in a table
- Update existing employee information
- Delete employee records

### Patient Record Management System
- Add new patient records with name, age, disease, and treatment status
- View all patient records in a table
- Update existing patient information
- Delete patient records

## Technical Details

- Uses JSP, HTML, CSS, and JDBC
- Employs PreparedStatement for database operations to prevent SQL injection
- Includes basic form validation
- Displays success/error messages after each operation
- Separate dbConnection.jsp files for each application (can be shared if preferred)

## Troubleshooting

1. **Database Connection Errors**:
   - Verify MySQL server is running
   - Check username/password in dbConnection.jsp
   - Ensure database `jsp_crud_db` exists
   - Verify MySQL Connector/J is in Tomcat's lib directory

2. **404 Errors**:
   - Verify applications are correctly deployed to webapps directory
   - Check Tomcat logs for deployment errors
   - Ensure Tomcat is running on port 8080 (default)

3. **JSP Compilation Errors**:
   - Ensure Tomcat is using a compatible Java version
   - Check JSP syntax for any errors