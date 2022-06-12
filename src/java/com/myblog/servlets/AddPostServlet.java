
package com.myblog.servlets;

import com.myblog.dao.PostDao;
import com.myblog.entities.Post;
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
public class AddPostServlet extends HttpServlet {

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
            int cid=Integer.parseInt(request.getParameter("cid"));
            String pTitle=request.getParameter("ptitle");
            String pContent=request.getParameter("pcontent");
            String pCode=request.getParameter("pcode");
            Part pPic=request.getPart("pic");
            HttpSession ses=request.getSession();
            User u=(User)ses.getAttribute("CurrentUser");
            
            
            Post post=new Post(pTitle, pContent, pCode, pPic.getSubmittedFileName(),cid,u.getUid());
            PostDao pd=new PostDao(ConnectionProvider.getConnection());
            if(pd.savePost(post))
            {
                String path=request.getRealPath("/")+"post_pics"+File.separator+pPic.getSubmittedFileName();
                FileClss.saveFile(pPic.getInputStream(),path);
                out.println("Success");
                        
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
