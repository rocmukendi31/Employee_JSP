<%@ page import="java.sql.*" %>
<%@ include file="dbConnection.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Patient</title>
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
        input[type="number"] {
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
        <h1>Add New Patient</h1>

        <%
            String message = (String) request.getAttribute("message");
            String messageType = (String) request.getAttribute("messageType");
            if (message != null) {
        %>
        <div class="message <%=messageType%>"><%=message%></div>
        <% } %>

        <form method="post" action="addPatient.jsp">
            <div class="form-group">
                <label for="patient_name">Patient Name:</label>
                <input type="text" id="patient_name" name="patient_name" required>
            </div>

            <div class="form-group">
                <label for="age">Age:</label>
                <input type="number" id="age" name="age" required>
            </div>

            <div class="form-group">
                <label for="disease">Disease:</label>
                <input type="text" id="disease" name="disease" required>
            </div>

            <div class="form-group">
                <label for="treatment_status">Treatment Status:</label>
                <input type="text" id="treatment_status" name="treatment_status" required>
            </div>

            <div class="form-group">
                <button type="submit" class="btn">Add Patient</button>
                <a href="index.jsp" class="btn btn-back">Back to List</a>
            </div>
        </form>

        <%
            String patientName = request.getParameter("patient_name");
            String ageStr = request.getParameter("age");
            String disease = request.getParameter("disease");
            String treatmentStatus = request.getParameter("treatment_status");

            if (patientName != null && ageStr != null && disease != null && treatmentStatus != null &&
                !patientName.isEmpty() && !ageStr.isEmpty() && !disease.isEmpty() && !treatmentStatus.isEmpty()) {

                try {
                    int age = Integer.parseInt(ageStr);

                    PreparedStatement ps = connection.prepareStatement(
                        "INSERT INTO patients (patient_name, age, disease, treatment_status) VALUES (?, ?, ?, ?)"
                    );
                    ps.setString(1, patientName);
                    ps.setInt(2, age);
                    ps.setString(3, disease);
                    ps.setString(4, treatmentStatus);

                    int rows = ps.executeUpdate();
                    if (rows > 0) {
                        response.sendRedirect("index.jsp?message=Patient added successfully&messageType=success");
                    } else {
                        request.setAttribute("message", "Failed to add patient");
                        request.setAttribute("messageType", "error");
                    }
                    ps.close();
                } catch (NumberFormatException ex) {
                    request.setAttribute("message", "Invalid age format");
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