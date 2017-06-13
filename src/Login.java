

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Hotel
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		//System.out.println(request.getParameter("email")+request.getParameter("pwd"));
		/*TODO
		 * Compare the the username and password with database values.
		 * Using printwriter, display alert/modal on browser
		 */
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		String email=request.getParameter("email");
		String pwd=request.getParameter("pwd");
		PrintWriter out=response.getWriter();
		out.println("<html><body>");
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection("jdbc:mysql://localhost/project","root","root");
			stmt=conn.createStatement();
			String sql="select id,password from customer where email='"+email+"' ";
			rs=stmt.executeQuery(sql);
			if(rs.next()){
				if(pwd.equals(rs.getString(2))){
					sql="insert into cust_id values("+rs.getInt(1)+")";
					stmt.executeUpdate(sql);
					out.println("<script>alert('Login successful!'); document.location='loginhome.jsp';</script>");
				}
				else
					out.println("<script>alert('Wrong Password'); document.location='login.html';</script>");
			}
			else
				out.println("<script>alert('Wrong Username or Password'); document.location='login.html';</script>");
			out.println("</body></html>");
			
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
