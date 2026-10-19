<%@ page import="java.sql.*" %>
<%@ include file="dbConnection.jsp" %>
<%
    String employeeIdStr = request.getParameter("employee_id");
    String employeeName = request.getParameter("employee_name");
    String department = request.getParameter("department");
    String salaryStr = request.getParameter("salary");

    String message = "";
    String messageType = "";

    try {
        int employeeId = Integer.parseInt(employeeIdStr);
        double salary = Double.parseDouble(salaryStr);

        PreparedStatement ps = connection.prepareStatement(
            "UPDATE employees SET employee_name = ?, department = ?, salary = ? WHERE employee_id = ?"
        );
        ps.setString(1, employeeName);
        ps.setString(2, department);
        ps.setDouble(3, salary);
        ps.setInt(4, employeeId);

        int rows = ps.executeUpdate();
        if (rows > 0) {
            message = "Employee updated successfully";
            messageType = "success";
        } else {
            message = "Failed to update employee";
            messageType = "error";
        }
        ps.close();
    } catch (NumberFormatException ex) {
        message = "Invalid input format";
        messageType = "error";
    } catch (Exception ex) {
        message = "Database error: " + ex.getMessage();
        messageType = "error";
    }

    request.setAttribute("message", message);
    request.setAttribute("messageType", messageType);
    RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
    dispatcher.forward(request, response);
%>