<%@ page import = "java.sql.*" %>

<%
    if ((session.getAttribute("user") == null) || !(session.getAttribute("role").equals("Manager"))) {
        response.sendRedirect("../index.html");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Revenue Summary</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css">
</head>
<body>
<a class="admin_back_link" href='Manage.jsp'>Back To Admin Panel</a><br>
<%
    String line = request.getParameter("line");
    out.println("<h3>Transit Line: " + line + "</h3>");

    try {
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        Connection con = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "group19", "database");
        Statement st = con.createStatement();

        ResultSet rs = st.executeQuery("SELECT SUM(total_fare + booking_fee) FROM Reservations r JOIN Train_Schedule ts ON r.scheduleID=ts.scheduleID WHERE transitlinename='" + line + "'");
        if (rs.next()) {
            out.println("<h3>Total Revenue: $" + rs.getString(1) + "</h3>");
        }

        rs = st.executeQuery("SELECT * FROM Reservations r JOIN Train_Schedule ts ON r.scheduleID=ts.scheduleID WHERE transitlinename='" + line + "'");
        %>
        <h3>Reservations:</h3>
        <table>
            <tr>
                <th>Reservation Number</th>
                <th>Date Created</th>
                <th>Passenger Username</th>
                <th>Departure Date/Time</th>
                <th>Class</th>
                <th>Seat Number</th>
                <th>Total Fare</th>
                <th>Booking Fee</th>
                <th>Customer Representative</th>
            </tr>
                <% while (rs.next()) { %>
            <tr>
                <td><%=rs.getString("res_num")%></td>
                <td><%=rs.getString("res_date")%></td>
                <td><%=rs.getString("username")%></td>
                <td><%=rs.getString("dep_datetime")%></td>
                <td><%=rs.getString("class")%></td>
                <td><%=rs.getString("seat_num")%></td>
                <td><%=rs.getString("total_fare")%></td>
                <td><%=rs.getString("booking_fee")%></td>
                <td><%=rs.getString("cust_rep")%></td>
            </tr>
        <% }
        con.close();
        st.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
</body>
</html>
