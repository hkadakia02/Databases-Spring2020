<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search Reservations By Line & Number</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css">
</head>
<body>
<%
    try {
        String line = request.getParameter("line");
        String train = request.getParameter("train");
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        Connection con = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "group19", "database");
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT * FROM Reservations r JOIN Train_Schedule ts ON r.scheduleID=ts.scheduleID WHERE transitlinename='" + line + "' AND tid=" + train);
        %>
Transit Line: <%=line%>
<br>
Train Number: <%=train%>
<br>
<h3>Reservations:</h3>
<table>
    <tr>
        <th>Reservation Number</th>
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
        <% while (rs.next()) { %>
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
    } catch (Exception e) {
        e.printStackTrace();
    }
    %>
</table>
<br>
<a href='Manage.jsp'>Admin Panel</a>
</body>
</html>
