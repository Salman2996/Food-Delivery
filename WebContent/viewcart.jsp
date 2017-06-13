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
<title>Cart</title>
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
		ResultSet rs=null, rs1=null, rs2=null;
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
        			<li><a href="menu.jsp">Menu</a></li>
        			<li><a href="comingsoon.jsp">Deals</a></li>
        			<li><a href="comingsoon.jsp">Contact</a></li>
      			</ul>
      			<ul class="nav navbar-nav navbar-right">
        			<li><a href="login.html">Login</a></li>
        			<li><a href="signup.html">Sign Up</a></li>
        			<li class="active"><a href="viewcart.jsp"><span class="glyphicon glyphicon-shopping-cart"></span> Cart</a></li>
      			</ul>
      			
     <% 
			}else{
     %>
    
      			<ul class="nav navbar-nav">
        			<li><a href="loginhome.jsp">Home</a></li>
        			<li><a href="menu.jsp">Menu</a></li>
        			<li><a href="comingsoon.jsp">Deals</a></li>
        			<li><a href="comingsoon.jsp">Contact</a></li>
      			</ul>
      			<ul class="nav navbar-nav navbar-right">
        			<li><a href="profile.jsp">Welcome, <%= custName %></a></li>
        			<li><a href="signout.jsp">Sign Out</a></li>
        			<li class="active"><a href="viewcart.jsp"><span class="glyphicon glyphicon-shopping-cart"></span> Cart</a></li>
      			</ul>
     <%
			}
     %>
    		</div>
  		</div>
	</nav>
	
	<%	 
		String items="";
		int total=0, cust_id=0;
			
		//calculating total order price
		sql="select * from temp_order";
		rs1=stmt.executeQuery(sql);
		while(rs1.next()){
			items+=rs1.getString(1)+",";
			total+=rs1.getInt(2);
		}
		items=items.substring(0,items.length()-1);
		rs1.close();
			
		//getting customer id
		sql="select * from cust_id";
		rs2=stmt.executeQuery(sql);
		if(rs2.next())
			cust_id=rs2.getInt(1);
			
		//entering into table cust_order
		sql="insert into cust_order(items,total,cust_id) values('"+items+"', "+total+", "+cust_id+")";
		stmt.executeUpdate(sql);
	%>
	
	<div class="container">
  		<table class="table">
    		<thead>
      			<tr>
        			<th>Item</th>
        			<th>Price</th>
      			</tr>
    		</thead>
    <%
  		//diplaying bill
    	sql="select * from temp_order";
		rs1=stmt.executeQuery(sql);
    	while(rs1.next()){
    %>	
    
    		<tbody>     
      			<tr class="info">
        			<td><%= rs1.getString(1) %></td>
        			<td><%= rs1.getInt(2) %></td>
			    </tr>
	<%
  		}
    %>
    			<tr class="info">
    				<td>Total</td>
    				<td><%= total %></td>
    			</tr>
    <%
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			try{
				rs.close();
				rs1.close();
				rs2.close();
				stmt.close();
				conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	%>
    		</tbody>
  		</table>
	</div><br>
	
	<center>
		<a href="remove.jsp" class="btn btn-primary">Remove</a>
		<a href="menu.jsp" class="btn btn-primary">Add More</a>
		<a href="checkout.jsp" class="btn btn-primary">Checkout</a>
	</center><br><br>
	
	<footer class="container-fluid text-center">
  		<p>Developed by:</p>  
  		<br>
  		<p>Salman R, 1MS14IS092</p>
  		<p>Saniya F, 1MS14IS095</p>
	</footer>
</body>
</html>