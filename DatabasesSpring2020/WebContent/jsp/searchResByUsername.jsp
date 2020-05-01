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
    <title>Search Reservations By Username</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css">
</head>
<body>
<a class="admin_back_link" href='Manage.jsp'>Back To Admin Panel</a><br>
<%
    try {
        String username = request.getParameter("username");
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        Connection con = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "group19", "database");
        Statement st = con.createStatement();
        ResultSet rs;
        rs = st.executeQuery("SELECT * FROM Users WHERE username='" + username + "'");
        if (!rs.next()){
            out.println("Error: User '" + username + "' Not Found");
            con.close();
            st.close();
            return;
        } else if (!rs.getString("role").equals("Customer")) {
            out.println("Error: '" + username + "' Is Not A Customer");
            con.close();
            st.close();
            return;
        } else {
            rs = st.executeQuery("SELECT * FROM Reservations WHERE username='" + username + "'");
            if (!rs.next()) {
                out.println("No reservations found for Customer Username '" + username + "'");
            } else { %>
            <h3>Customer: '<%=username%>'</h3>
            <h3>Reservations:</h3>
            <table>
                <tr>
                    <th>Reservation #</th>
                    <th>Date Created</th>
                    <th>Departure Date/Time</th>
                    <th>Schedule ID</th>
                    <th>Origin Station</th>
                    <th>Destination Station</th>
                    <th>Class</th>
                    <th>Seat #</th>
                    <th>Total Fare</th>
                    <th>Booking Fee</th>
                    <th>Customer Representative</th>
                </tr>
            <% }
            while (rs.next()) { %>
                <tr>
                    <td><%=rs.getString("res_num")%></td>
                    <td><%=rs.getString("res_date")%></td>
                    <td><%=rs.getString("dep_datetime")%></td>
                    <td><%=rs.getString("scheduleID")%></td>
                    <td><%=rs.getString("origin_station")%></td>
                    <td><%=rs.getString("dest_station")%></td>
                    <td><%=rs.getString("class")%></td>
                    <td><%=rs.getString("seat_num")%></td>
                    <td><%=rs.getString("total_fare")%></td>
                    <td><%=rs.getString("booking_fee")%></td>
                    <td><%=rs.getString("cust_rep")%></td>
                </tr>
            <% }
        }
        con.close();
        st.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
</table>
</body>
</html>