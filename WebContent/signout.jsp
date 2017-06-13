<%@ page language="java" import="java.sql.*"
		 contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sign Out</title>
</head>
<body>
	<%
		Connection conn=null;
		Statement stmt=null;
		String custName=null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection("jdbc:mysql://localhost/project","root","root");
			stmt=conn.createStatement();
			String sql="delete from cust_id";
			stmt.executeUpdate(sql);
			sql="delete from temp_order";
			stmt.executeUpdate(sql);
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			try{
				stmt.close();
				conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	%>
	
	<script type="text/javascript">
		alert("Signed out successfully!");
		location="home.jsp";
	</script>
</body>
</html>