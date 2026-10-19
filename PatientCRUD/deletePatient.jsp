<%@ page import="java.sql.*" %>
<%@ include file="dbConnection.jsp" %>
<%
    String idStr = request.getParameter("id");
    String message = "";
    String messageType = "";

    try {
        int patientId = Integer.parseInt(idStr);

        PreparedStatement ps = connection.prepareStatement(
            "DELETE FROM patients WHERE patient_id = ?"
        );
        ps.setInt(1, patientId);

        int rows = ps.executeUpdate();
        if (rows > 0) {
            message = "Patient deleted successfully";
            messageType = "success";
        } else {
            message = "Failed to delete patient";
            messageType = "error";
        }
        ps.close();
    } catch (NumberFormatException ex) {
        message = "Invalid patient ID";
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