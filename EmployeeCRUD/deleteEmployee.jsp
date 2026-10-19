<%@ page import="java.sql.*" %>
<%@ include file="dbConnection.jsp" %>
<%
    String idStr = request.getParameter("id");
    String message = "";
    String messageType = "";

    try {
        int employeeId = Integer.parseInt(idStr);

        PreparedStatement ps = connection.prepareStatement(
            "DELETE FROM employees WHERE employee_id = ?"
        );
        ps.setInt(1, employeeId);

        int rows = ps.executeUpdate();
        if (rows > 0) {
            message = "Employee deleted successfully";
            messageType = "success";
        } else {
            message = "Failed to delete employee";
            messageType = "error";
        }
        ps.close();
    } catch (NumberFormatException ex) {
        message = "Invalid employee ID";
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