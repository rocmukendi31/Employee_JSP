<%@ page import="java.sql.*" %>
<%@ include file="dbConnection.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Employee Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #2c3e50;
            text-align: center;
        }
        .btn {
            display: inline-block;
            padding: 10px 15px;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            margin: 5px;
        }
        .btn:hover {
            background-color: #2980b9;
        }
        .btn-delete {
            background-color: #e74c3c;
        }
        .btn-delete:hover {
            background-color: #c0392b;
        }
        .btn-edit {
            background-color: #2ecc71;
        }
        .btn-edit:hover {
            background-color: #27ae60;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #3498db;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
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
        <h1>Employee Management System</h1>

        <%
            String message = (String) request.getAttribute("message");
            String messageType = (String) request.getAttribute("messageType");
            if (message != null) {
        %>
        <div class="message <%=messageType%>"><%=message%></div>
        <% } %>

        <a href="addEmployee.jsp" class="btn">Add New Employee</a>

        <table>
            <thead>
                <tr>
                    <th>Employee ID</th>
                    <th>Employee Name</th>
                    <th>Department</th>
                    <th>Salary</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        if (connection != null && !connection.isClosed()) {
                            Statement stmt = connection.createStatement();
                            ResultSet rs = stmt.executeQuery("SELECT * FROM employees ORDER BY employee_id");

                            while (rs.next()) {
                %>
                <tr>
                    <td><%=rs.getInt("employee_id")%></td>
                    <td><%=rs.getString("employee_name")%></td>
                    <td><%=rs.getString("department")%></td>
                    <td><%=rs.getDouble("salary")%></td>
                    <td>
                        <a href="editEmployee.jsp?id=<%=rs.getInt("employee_id")%>" class="btn btn-edit">Edit</a>
                        <a href="deleteEmployee.jsp?id=<%=rs.getInt("employee_id")%>" class="btn btn-delete" onclick="return confirm('Are you sure you want to delete this employee?')">Delete</a>
                    </td>
                </tr>
                <%
                            }
                            rs.close();
                            stmt.close();
                        }
                    } catch (Exception ex) {
                %>
                <tr>
                    <td colspan="5">Error retrieving data: <%=ex.getMessage()%></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>