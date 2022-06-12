/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.myblog.servlets;

import com.myblog.dao.UserDao;
import com.myblog.entities.Message;
import com.myblog.entities.User;
import com.myblog.helper.ConnectionProvider;
import com.myblog.helper.FileClss;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author 91706
 */
@MultipartConfig
public class UpdateServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String name=request.getParameter("name");
            String email=request.getParameter("email");
            String password=request.getParameter("password");
            String about=request.getParameter("about");
            Part part=request.getPart("photo");
            String imagename=part.getSubmittedFileName();
            HttpSession ses=request.getSession();
            User user=(User)ses.getAttribute("CurrentUser");
            user.setName(name);
            user.setEmail(email);
            user.setPassword(password);
            user.setAbout(about);
            String oldphoto=user.getImage_name();
            user.setImage_name(imagename);
            UserDao userdao=new UserDao(ConnectionProvider.getConnection());
            boolean res=userdao.updateUser(user);
           if(res)
           {
               
               
              String oldphotopath=request.getRealPath("/")+"user_pics"+File.separator+oldphoto;
              if(!oldphoto.equals("default.jpg")){
              FileClss.deleteFile(oldphotopath);
              }
              String newPhotopath=request.getRealPath("/")+"user_pics"+File.separator+imagename;
                  if(FileClss.saveFile(part.getInputStream(), newPhotopath))
                  {
                      out.println("Success");
               Message msg2=new Message("User Updated Successfully !","Success", "alert alert-success");
               ses.setAttribute("msg2", msg2);
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
