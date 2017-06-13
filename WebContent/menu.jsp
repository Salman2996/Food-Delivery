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
<title>Menu</title>
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
    
     .img{
    height: 100%;
    width: auto;
    }
    
    .panel-height {
  	height: 250px;
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
			if(custName==null){
	%>
      			
      			<ul class="nav navbar-nav">
        			<li><a href="home.jsp">Home</a></li>
        			<li class="active"><a href="menu.jsp">Menu</a></li>
        			<li><a href="comingsoon.jsp">Deals</a></li>
        			<li><a href="comingsoon.jsp">Contact</a></li>
      			</ul>
      			<ul class="nav navbar-nav navbar-right">
        			<li><a href="login.html">Login</a></li>
        			<li><a href="signup.html">Sign Up</a></li>
        			<li><a href="viewcart.jsp"><span class="glyphicon glyphicon-shopping-cart"></span> Cart</a></li>
      			</ul>
      			
     <% 
			}else{
     %>
    
      			<ul class="nav navbar-nav">
        			<li><a href="loginhome.jsp">Home</a></li>
        			<li class="active"><a href="menu.jsp">Menu</a></li>
        			<li><a href="comingsoon.jsp">Deals</a></li>
        			<li><a href="comingsoon.jsp">Contact</a></li>
      			</ul>
      			<ul class="nav navbar-nav navbar-right">
        			<li><a href="profile.jsp">Welcome, <%= custName %></a></li>
        			<li><a href="signout.jsp">Sign Out</a></li>
        			<li><a href="viewcart.jsp"><span class="glyphicon glyphicon-shopping-cart"></span> Cart</a></li>
      			</ul>
     <%
			}
     %>
    		</div>
  		</div>
	</nav>
	
	<div class="container">    
  		<div class="row">
	<%
			rs.close();
			sql="select * from menu";
			rs=stmt.executeQuery(sql);
			while(rs.next()){
				String food_name=rs.getString(2);
				int price=rs.getInt(3);
				String link=rs.getString(4);
	%>
    		<div class="col-sm-4">
      			<div class="panel panel-primary">
        			<div class="panel-heading"><%= food_name %></div>
        			<div class="panel-body panel-height"><img src="<%= link %>" class="img-responsive img" alt="<%= food_name %>"></div>
        			<div class="panel-footer">Price: <%= price %><a href="cart.jsp?item=<%= food_name %>" class="btn btn-primary pull-right">Add to Cart</a></div>
        			<div class="clearfix"></div>
      			</div>
    		</div>		
	<%
			}
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
		</div>
	</div><br><br>
	
	<footer class="container-fluid text-center">
  		<p>Developed by:</p>  
  		<br>
  		<p>Salman R, 1MS14IS092</p>
  		<p>Saniya F, 1MS14IS095</p>
	</footer>
</body>
</html>