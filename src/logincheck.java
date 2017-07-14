import java.io.IOException;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JOptionPane;


public class logincheck extends HttpServlet {
	java.sql.Connection conn=null;
	public void wrongNullUsername(){
		String msg="用户名不能为空";
		int type=JOptionPane.YES_NO_CANCEL_OPTION;
		String title="信息提示";
		JOptionPane.showMessageDialog(null, msg,title,type);
	}
	public void wrongNullPassword(){
		String msg="密码不能为空";
		int type=JOptionPane.YES_NO_CANCEL_OPTION;
		String title="信息提示";
		JOptionPane.showMessageDialog(null, msg,title,type);
	}
	public void login(){
		String msg="登录成功";
		int type=JOptionPane.YES_NO_CANCEL_OPTION;
		String title="信息提示";
		JOptionPane.showMessageDialog(null, msg,title,type);
	}
	public void wrongPassword(){
		String msg="密码错误";
		int type=JOptionPane.YES_NO_CANCEL_OPTION;
		String title="信息提示";
		JOptionPane.showMessageDialog(null, msg,title,type);
	}
	public void notExist(){
		String msg="用户名不存在";
		int type=JOptionPane.YES_NO_CANCEL_OPTION;
		String title="信息提示";
		JOptionPane.showMessageDialog(null, msg,title,type);
	}
	/**
	 * Constructor of the object.
	 */
	public logincheck() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request,response);
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Integer username=Integer.parseInt(request.getParameter("username"));
		String password=request.getParameter("password");
		String limit=request.getParameter("limit");
		if(username.equals(""))
		{
			wrongNullUsername();
			response.sendRedirect("login.jsp");
		}
		else if(password.equals(""))
		{
			wrongNullPassword();
			response.sendRedirect("login.jsp");
		}
		else{
		try{
		String sql="select * from Chenzy_login where czy_username="+username+"and czy_pwd="+password+"and czy_limit="+limit;
		String sql1="select * from Chenzy_login where czy_username="+username;
		java.sql.Statement stmt=conn.createStatement();
		ResultSet rs=stmt.executeQuery(sql);
		if(rs.next()){
			request.getSession().setAttribute("username", username);
			login();
			if(limit.equals("1")){
				response.sendRedirect("student.jsp");
			}
			else if(limit.equals("2")){
				response.sendRedirect("teacher.jsp");
			}
			else if (limit.equals("3")){
				response.sendRedirect("administrator.jsp");
			}
		}
		else if(stmt.executeQuery(sql1).next()){
			wrongPassword();
			response.sendRedirect("login.jsp");
		}
		else{
			notExist();
			response.sendRedirect("login.jsp");
		}
		}catch (SQLException e) {
			e.printStackTrace();
		}
		}
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		try{
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			String url="jdbc:sqlserver://localhost:1433;databasename=chenzeyuan03Mis";
			conn=DriverManager.getConnection(url,"sa","root");
		}catch (ClassNotFoundException e) {
			System.out.println(e);
		}catch(SQLException e1){}
	}

}
