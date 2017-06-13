

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

/**
 * Servlet implementation class RemoveFromCart
 */
@WebServlet("/RemoveFromCart")
public class RemoveFromCart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RemoveFromCart() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		PrintWriter out=response.getWriter();
		out.println("<html><body>");
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection("jdbc:mysql://localhost/project","root","root");
			stmt=conn.createStatement();
			String sql;
			for(String s : request.getParameterValues("removeitems")){
				sql="delete from temp_order where item='"+s+"'";
				stmt.executeUpdate(sql);
			}
			sql="select * from temp_order";
			rs=stmt.executeQuery(sql);
			String item="";
			int total=0, cust_id=0;
			while(rs.next()){
				item+=rs.getString(1)+",";
				total+=rs.getInt(2);
			}
			item=item.substring(0,item.length()-1);
			sql="delete from cust_order order by order_id desc limit 1";
			stmt.executeUpdate(sql);
			rs.close();
			sql="select * from cust_id";
			rs=stmt.executeQuery(sql);
			if(rs.next())
				cust_id=rs.getInt(1);
			sql="insert into cust_order(items,total,cust_id) values('"+item+"', "+total+", "+cust_id+")";
			stmt.executeUpdate(sql);
			sql="delete from cust_order where cust_id=0";
			stmt.executeUpdate(sql);
			out.println("<script> alert('Items removed'); document.location='viewcart.jsp'; </script>");
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
			
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
	}

}
