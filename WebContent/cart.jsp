<%@ page language="java" import="java.sql.*, java.util.*"
		contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Adding</title>
</head>
<body>
	<%
		String food_name=request.getParameter("item");
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		int price=0;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection("jdbc:mysql://localhost/project","root","root");
			stmt=conn.createStatement();
			String sql="select price from menu where food_name='"+food_name+"'";
			rs=stmt.executeQuery(sql);
			if(rs.next())
				price=rs.getInt(1);
  			sql="insert into temp_order values('"+food_name+"', "+price+")";
			stmt.executeUpdate(sql);
	%>
	<%
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			try{
				rs.close();
				stmt.close();
				conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	%>
	
	<script>
		if (confirm("Add More?") == true) {
			location="menu.jsp";
	    } else {
	    	location="viewcart.jsp";
	    }
	</script>
</body>
</html>