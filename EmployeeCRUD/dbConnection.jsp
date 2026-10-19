<%@ page import="java.sql.*" %>
<%
    String connectionURL = "jdbc:mysql://localhost:3306/jsp_crud_db";
    String connectionUser = "root"; // TODO: Replace with your MySQL username
    String connectionPassword = ""; // TODO: Replace with your MySQL password - DO NOT COMMIT PASSWORDS TO GIT
    Connection connection = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
        connection = DriverManager.getConnection(connectionURL, connectionUser, connectionPassword);
    } catch (Exception ex) {
        out.println("Unable to connect to database: " + ex.getMessage());
    }
%>