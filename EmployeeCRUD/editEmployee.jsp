<%@ page import="java.sql.*" %>
<%@ include file="dbConnection.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Employee</title>
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
            background-color: #f39c12;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            margin: 5px;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #d35400;
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
        <h1>Edit Employee</h1>

        <%
            String message = (String) request.getAttribute("message");
            String messageType = (String) request.getAttribute("messageType");
            if (message != null) {
        %>
        <div class="message <%=messageType%>"><%=message%></div>
        <% } %>

        <%
            String idStr = request.getParameter("id");
            int employeeId = 0;
            String employeeName = "";
            String department = "";
            double salary = 0.0;

            try {
                if (idStr != null && !idStr.isEmpty()) {
                    employeeId = Integer.parseInt(idStr);

                    PreparedStatement ps = connection.prepareStatement(
                        "SELECT * FROM employees WHERE employee_id = ?"
                    );
                    ps.setInt(1, employeeId);
                    ResultSet rs = ps.executeQuery();

                    if (rs.next()) {
                        employeeName = rs.getString("employee_name");
                        department = rs.getString("department");
                        salary = rs.getDouble("salary");
                    }
                    rs.close();
                    ps.close();
                }
            } catch (Exception ex) {
        %>
        <div class="message error">Error loading employee: <%=ex.getMessage()%></div>
        <%
            }
        %>

        <form method="post" action="updateEmployee.jsp">
            <input type="hidden" name="employee_id" value="<%=employeeId%>">

            <div class="form-group">
                <label for="employee_name">Employee Name:</label>
                <input type="text" id="employee_name" name="employee_name" value="<%=employeeName%>" required>
            </div>

            <div class="form-group">
                <label for="department">Department:</label>
                <input type="text" id="department" name="department" value="<%=department%>" required>
            </div>

            <div class="form-group">
                <label for="salary">Salary:</label>
                <input type="number" step="0.01" id="salary" name="salary" value="<%=salary%>" required>
            </div>

            <div class="form-group">
                <button type="submit" class="btn">Update Employee</button>
                <a href="index.jsp" class="btn btn-back">Back to List</a>
            </div>
        </form>
    </div>
</body>
</html>