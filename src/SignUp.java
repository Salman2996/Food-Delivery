

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

/**
 * Servlet implementation class SignUp
 */
@WebServlet("/SignUp")
public class SignUp extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SignUp() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		Connection conn=null;
		Statement stmt=null;
		String name=request.getParameter("name");
		String phno=request.getParameter("phno");
		String addr=request.getParameter("addr");
		String email=request.getParameter("email");
		String pwd=request.getParameter("pwd");
		PrintWriter out=response.getWriter();
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection("jdbc:mysql://localhost/project","root","root");
			stmt=conn.createStatement();
			String sql="insert into customer(name, phno, address, email, password) values('"
					+ name +"', '"
					+ phno +"', '"
					+ addr +"', '"
					+ email +"', '"
					+ pwd +"')";
			if(conn!=null){
				stmt.executeUpdate(sql);
				out.println("<script>alert('SignUp successful'); document.location='login.html';</script>");
			}
			else
				out.println("<script>alert('Connection refused'); document.location='signup.html';</script>");
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
