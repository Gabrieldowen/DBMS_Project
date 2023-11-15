<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Query Result</title>
</head>
    <body>
    <%@page import="jsp_azure_test.DataHandler"%>
    <%@page import="java.sql.ResultSet"%>
    <%@page import="java.sql.Array"%>
    <%
    // The handler is the one in charge of establishing the connection.
    DataHandler handler = new DataHandler();

    // Get the attribute values passed from the input form.
    String CustomerName = request.getParameter("CustomerName");
    String Address = request.getParameter("Address");
    int Category = request.getParameter("Category");


    /*
     * If the user hasn't filled out all the time, movie name and duration. This is very simple checking.
     */
    if (CustomerName.equals("") || Address.equals("") || Category.equals("")) {
        response.sendRedirect("add_Customer_form.jsp");
    } else {
        int duration = Integer.parseInt(durationString);
        
        // Now perform the query with the data from the form.
        boolean success = handler.addMovie(CustomerName, Address, Category);
        if (!success) { // Something went wrong
            %>
                <h2>There was a problem inserting the course</h2>
            <%
        } else { // Confirm success to the user
            %>
            <h2>Customer:</h2>

            <ul>
                <li>CustomerName: <%=CustomerName%></li>
                <li>Address: <%=Address%></li>
                <li>Category: <%=Category%></li>
            </ul>

            <h2>Was successfully inserted.</h2>
            
            <a href="getCustomerjsp">See all Customers.</a>
            <%
        }
    }
    %>
    </body>
</html>
