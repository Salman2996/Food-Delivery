<%@ page language="java" import="java.sql.*"
		 contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>Profile</title>
<style> 
    .navbar {
      margin-bottom: 50px;
      border-radius: 0;
    }
     
     .jumbotron {
      margin-bottom: 0;
      /* background-image: url("");
      background-size: cover;
      background-repeat: no-repeat;
      background-position: center; */
    }
   
    footer {
      background-color: #f2f2f2;
      padding: 25px;
    }
</style>
</head>
<body>
	<div class="jumbotron">
  		<div class="container text-center">
    		<h1>Nom Nom Guru</h1>      
    		<h4>Need we say more</h4>
  		</div>
	</div>
	
	<%
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		String custName=null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection("jdbc:mysql://localhost/project","root","root");
			stmt=conn.createStatement();
			String sql="select name from customer where id=(select id from cust_id)";
			rs=stmt.executeQuery(sql);
			if(rs.next()){
				custName=rs.getString(1);
			}
	%>

	<nav class="navbar navbar-inverse">
  		<div class="container-fluid">
    		<div class="navbar-header">
      			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        			<span class="icon-bar"></span>
        			<span class="icon-bar"></span>
        			<span class="icon-bar"></span>                        
      			</button>
      			<a class="navbar-brand" href="#">Nom Nom</a>
    		</div>
    		<div class="collapse navbar-collapse" id="myNavbar">
      			<ul class="nav navbar-nav">
        			<li><a href="loginhome.jsp">Home</a></li>
        			<li><a href="menu.jsp">Menu</a></li>
        			<li><a href="comingsoon.jsp">Deals</a></li>
        			<li><a href="comingsoon.jsp">Contact</a></li>
      			</ul>
      			<ul class="nav navbar-nav navbar-right">
        			<li class="active"><a href="profile.jsp">Welcome, <%= custName %></a></li>
        			<li><a href="signout.jsp">Sign Out</a></li>
        			<li><a href="viewcart.jsp"><span class="glyphicon glyphicon-shopping-cart"></span> Cart</a></li>
      			</ul>
    		</div>
  		</div>
	</nav>
	
	<%
		String name="",address="";
		long phno=0;
		rs.close();
		sql="select name,address,phno from customer where id=(select id from cust_id)";
		rs=stmt.executeQuery(sql);
		if(rs.next()){
			name=rs.getString(1);
			address=rs.getString(2);
			phno=rs.getLong(3);
		}
	%>
	
	<div class="container">
		<center><h2 class="bg-primary">Profile</h2></center>
  		<p class="bg-info">Name: <%= name %></p>
  		<p class="bg-info">Address: <%= address %></p>
  		<p class="bg-info">Contact No.: <%= phno %></p>
  		<!-- Do later if in the mood -->
  		<!-- <center>
  			<a href="#" class="btn btn-primary">Edit</a> 
    	</center> -->
	</div><br>
	
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
		
	<footer class="container-fluid text-center">
	  	<p>Developed by:</p>  
	  	<br>
	  	<p>Salman R, 1MS14IS092</p>
	  	<p>Saniya F, 1MS14IS095</p>
	</footer>
</body>
</html>