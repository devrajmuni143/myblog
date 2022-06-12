
package com.myblog.servlets;

import com.myblog.dao.UserDao;
import com.myblog.entities.User;
import com.myblog.helper.ConnectionProvider;
import com.myblog.helper.FileClss;
import java.io.File;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig

public class RegisterServlet extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
           
            String termAndcon=request.getParameter("cond");
            if(termAndcon==null)
            {
                out.println("Check Terms & Conditions !");
            }
            else{
                String name=request.getParameter("username");
                String email=request.getParameter("email");
                String password=request.getParameter("password");
                String gender=request.getParameter("gender");
                String about=request.getParameter("about");
                
                Part part=request.getPart("image");
                String photo=part.getSubmittedFileName();
                User user=new User(name,email,password,gender,about,photo);
                UserDao userdao=new UserDao(ConnectionProvider.getConnection());
                if(userdao.addUser(user)){
                    if(!photo.equals(null)){
                    String path=request.getRealPath("/")+"user_pics"+File.separator+photo;
                    FileClss.saveFile(part.getInputStream(), path);
                
                    }
                    out.println("Done");
                }else{
                    out.println("Error");
                }
                
            }
            
           
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
