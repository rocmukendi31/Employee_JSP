<%@ page import="java.sql.*" %>
<%@ include file="dbConnection.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Employee</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 500px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #2c3e50;
            text-align: center;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="text"],
        input[type="number"],
        input[type="decimal"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .btn {
            display: inline-block;
            padding: 10px 15px;
            background-color: #2ecc71;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            margin: 5px;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #27ae60;
        }
        .btn-back {
            background-color: #95a5a6;
        }
        .btn-back:hover {
            background-color: #7f8c8d;
        }
        .message {
            padding: 10px;
            margin: 10px 0;
            border-radius: 4px;
        }
        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Add New Employee</h1>

        <%
            String message = (String) request.getAttribute("message");
            String messageType = (String) request.getAttribute("messageType");
            if (message != null) {
        %>
        <div class="message <%=messageType%>"><%=message%></div>
        <% } %>

        <form method="post" action="addEmployee.jsp">
            <div class="form-group">
                <label for="employee_name">Employee Name:</label>
                <input type="text" id="employee_name" name="employee_name" required>
            </div>

            <div class="form-group">
                <label for="department">Department:</label>
                <input type="text" id="department" name="department" required>
            </div>

            <div class="form-group">
                <label for="salary">Salary:</label>
                <input type="number" step="0.01" id="salary" name="salary" required>
            </div>

            <div class="form-group">
                <button type="submit" class="btn">Add Employee</button>
                <a href="index.jsp" class="btn btn-back">Back to List</a>
            </div>
        </form>

        <%
            String employeeName = request.getParameter("employee_name");
            String department = request.getParameter("department");
            String salaryStr = request.getParameter("salary");

            if (employeeName != null && department != null && salaryStr != null &&
                !employeeName.isEmpty() && !department.isEmpty() && !salaryStr.isEmpty()) {

                try {
                    double salary = Double.parseDouble(salaryStr);

                    PreparedStatement ps = connection.prepareStatement(
                        "INSERT INTO employees (employee_name, department, salary) VALUES (?, ?, ?)"
                    );
                    ps.setString(1, employeeName);
                    ps.setString(2, department);
                    ps.setDouble(3, salary);

                    int rows = ps.executeUpdate();
                    if (rows > 0) {
                        response.sendRedirect("index.jsp?message=Employee added successfully&messageType=success");
                    } else {
                        request.setAttribute("message", "Failed to add employee");
                        request.setAttribute("messageType", "error");
                    }
                    ps.close();
                } catch (NumberFormatException ex) {
                    request.setAttribute("message", "Invalid salary format");
                    request.setAttribute("messageType", "error");
                } catch (Exception ex) {
                    request.setAttribute("message", "Database error: " + ex.getMessage());
                    request.setAttribute("messageType", "error");
                }
            }
        %>
    </div>
</body>
</html>