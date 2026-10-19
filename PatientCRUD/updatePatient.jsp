<%@ page import="java.sql.*" %>
<%@ include file="dbConnection.jsp" %>
<%
    String patientIdStr = request.getParameter("patient_id");
    String patientName = request.getParameter("patient_name");
    String ageStr = request.getParameter("age");
    String disease = request.getParameter("disease");
    String treatmentStatus = request.getParameter("treatment_status");

    String message = "";
    String messageType = "";

    try {
        int patientId = Integer.parseInt(patientIdStr);
        int age = Integer.parseInt(ageStr);

        PreparedStatement ps = connection.prepareStatement(
            "UPDATE patients SET patient_name = ?, age = ?, disease = ?, treatment_status = ? WHERE patient_id = ?"
        );
        ps.setString(1, patientName);
        ps.setInt(2, age);
        ps.setString(3, disease);
        ps.setString(4, treatmentStatus);
        ps.setInt(5, patientId);

        int rows = ps.executeUpdate();
        if (rows > 0) {
            message = "Patient updated successfully";
            messageType = "success";
        } else {
            message = "Failed to update patient";
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