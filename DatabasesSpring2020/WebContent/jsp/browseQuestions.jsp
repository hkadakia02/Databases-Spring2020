<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Browse Questions</title>
</head>
<body>
	<h3>Browse Questions</h3>
	<%
	    Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection con = DriverManager.getConnection("jdbc:mysql://rds19.csvrkelvffmz.us-east-2.rds.amazonaws.com:3306/rds19", "group19", "database");
		Statement st = con.createStatement();
		ResultSet rs;
		rs = st.executeQuery("select question, answer from Messages");
		while (rs.next()) {
			String question = rs.getString("question");
			String answer = rs.getString("answer");
			if (answer == null) {
				answer = "No answer. Please tell the customer rep to do their job.";
			}
			%>
				<p>Question: <%= question %></p>
				<p>Answer: <%= answer %></p>
			
			<%
		}
    %>
</body>
</html>