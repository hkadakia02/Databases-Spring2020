  <%@ page import = "java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Add Train Schedule</title>
	<link rel="stylesheet" type="text/css" href="../css/styles.css">
</head>
<body>
	<h4>Add a train schedule</h4>
	<%
	try{
	Class.forName("com.mysql.jdbc.Driver").newInstance();
        Connection con = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "group19", "database");
        Statement st = con.createStatement();
	
    String transitlinename = (String)request.getParameter("transitlinename");
    String origin_station=(String)request.getParameter("origin_station");
    String dest_station=(String)request.getParameter("dest_station");
    String fare_amount=(String)request.getParameter("fare_amount");
    String fare_type=(String)request.getParameter("fare_type");
    String fare_discount=(String)request.getParameter("fare_discount");
    String tid = (String)request.getParameter("tid");
    String total_seats = (String)request.getParameter("total_seats");
    String total_cars = (String)request.getParameter("total_cars");
    String avail_seats = (String)request.getParameter("avail_seats");
    String arrival_datetime = (String)request.getParameter("arrival_datetime");
    String dep_datetime = (String)request.getParameter("dep_datetime");
    String total_travel_time = (String)request.getParameter("total_travel_time");

    
    
    String i = "INSERT INTO Train(c1, c2, c3)" + "VALUES (?, ?, ?)";
    PreparedStatement p = con.prepareStatement(i);
    p.setString(1, tid);
    p.setString(2, total_seats);
    p.setString(3, total_cars);
    p.executeUpdate();
    
    String j = "INSERT INTO Transit_Line(c1, c2, c3, c4, c5, c6)" + "VALUES (?, ?, ?, ?, ?, ?)";
    PreparedStatement q = con.prepareStatement(j);
    q.setString(1, transitlinename);
    q.setString(2, origin_station);
    q.setString(3, dest_station);
    q.setString(4, fare_amount);
    q.setString(5, fare_type);
    q.setString(6, fare_discount);
    q.executeUpdate();
    
    String k = "INSERT INTO Train_Schedule(c1, c2, c3, c4, c5, c6)" + "VALUES (?, ?, ?, ?, ?, ? )";
    PreparedStatement r = con.prepareStatement(k);
    r.setString(1, transitlinename);
    r.setString(2, tid);
    r.setString(3, avail_seats);
    r.setString(4, arrival_datetime);
    r.setString(5, dep_datetime);
    r.setString(6, total_travel_time);
    r.executeUpdate();
    
    st.close();
    con.close();
    } catch (Exception ex) {
		out.print(ex);
	}
%>

	<form action="AddTrainSchedule.jsp" method="POST">
		<select id="sort" name="sort">
		        <option value="transitlinename">Transit Line Name</option>
			<option value="arrival_datetime">Arrival Time</option>
			<option value="dep_datetime">Departure Time</option>
			<option value="origin_station">Origin</option>
			<option value="dest_station">Destination</option>
			<option value="fare_amount">Fare</option>
			<option value="fare_type">Fare Type</option>
			<option value="fare_discount">Fare Discount</option>
			<option value="tid">Train ID</option>
			<option value="total_seats">total_seats</option>
			<option value="total_cars">total_cars</option>
			<option value="avail_seats">avail_seats</option>
			<option value="total_travel_time">total_travel_time</option>
		</select>
		<input type="submit" value="Submit"/>
	</form>
</body>
</html>
    
