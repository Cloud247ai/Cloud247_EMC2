

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

/**
 * Servlet implementation class Booking
 */
public class Booking extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        int age = Integer.parseInt(request.getParameter("age"));
        String date = request.getParameter("date");
        String phone = request.getParameter("phone");
        String occasion = request.getParameter("occasion");
        String hours = request.getParameter("hours");
        int totalBill = 0;

        // Bill Calculation
        switch (occasion) {
            case "Birthday celebrations":
                if (hours.equals("1 hour")) totalBill = 1500;
                else if (hours.equals("2 hours")) totalBill = 2000;
                else totalBill = 2500;
                break;

            case "Anniversary celebrations":
                if (hours.equals("1 hour")) totalBill = 2000;
                else if (hours.equals("2 hours")) totalBill = 2500;
                else totalBill = 3500;
                break;

            case "private Party":
                if (hours.equals("1 hour")) totalBill = 2000;
                else if (hours.equals("2 hours")) totalBill = 3000;
                else totalBill = 4000;
                break;

            default:
                totalBill = 1000;
        }

        // Database Insert
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/emc", "root", "ijustDh53@"
            );
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO booking(name, age, date, occasion, phone, hours, Totalbill) VALUES (?, ?, ?, ?, ?, ?, ?)"
            );
            ps.setString(1, name);
            ps.setInt(2, age);
            ps.setString(3, date);
            ps.setString(4, occasion);
            ps.setString(5, phone);
            ps.setString(6, hours);
            ps.setInt(7, totalBill);

            int i = ps.executeUpdate();
            if (i > 0) {
                System.out.println("Booking saved successfully.");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        // Pass data to confirmation page
        request.setAttribute("name", name);
        request.setAttribute("age", age);
        request.setAttribute("date", date);
        request.setAttribute("occasion", occasion);
        request.setAttribute("phone", phone);
        request.setAttribute("hours", hours);
        request.setAttribute("Totalbill", totalBill);

        // Forward to confirmation JSP
        RequestDispatcher rd = request.getRequestDispatcher("bookingconformation.jsp");
        rd.forward(request, response);
    }

    // Optional: Handle GET requests if needed
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("home.jsp"); // Or display a message
    }

}
