/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package edu.pucmm.pw.parcial2.servlets;

import edu.pucmm.pw.parcial2.entidades.Usuario;
import edu.pucmm.pw.parcial2.servicios.HashtagServicio;
import edu.pucmm.pw.parcial2.servicios.TweetServicio;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Date;
import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author Richard
 */
@MultipartConfig
@WebServlet(name = "crearTweet", urlPatterns = {"/crearTweet", "/ct"})
public class crearTweet extends HttpServlet {
    
    @Inject
    TweetServicio ts;
    @Inject
    HashtagServicio hs;
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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
                     
            boolean overSize = false;
            boolean nullValues = false;
            boolean allGood = false;
            boolean notLogged = false;
            //TweetServicio ts = new TweetServicio();

            //referencia del usuario logueado
            Usuario usuarioLogueado = (Usuario)request.getSession().getAttribute("usuarioLogueado");

            //recibimos los datos del tweet.
            String contenido = request.getParameter("contenido");
            String isPublicTweet = request.getParameter("isPublic");//default es que si
            boolean isPublic = false;
            if(isPublicTweet != null){
                if(isPublicTweet.equals("yes")){
                    isPublic = true;
                }
            }
            //imagen del tweet
            Part imageTweet = request.getPart("imagenTweet");
            String fn = null;
            if(usuarioLogueado != null){
                if(imageTweet != null && imageTweet.getSize() > 0){
                    InputStream isfotoTweet = imageTweet.getInputStream();

                    fn = getFileName(imageTweet);
                    String of = this.getServletContext().getRealPath(fn);
                    FileOutputStream os = new FileOutputStream(of);

                    // write bytes taken from uploaded file to target file
                    //se escriben los bytes del archivo subido al archivo destino en el servidor...
                    int ch = isfotoTweet.read();
                    long archiTam = 0;//para contar los bytes del archivo...
                    while (ch != -1) {
                         os.write(ch);
                         ch = isfotoTweet.read();
                         archiTam++;
                    }
                }
                if(contenido != null && !contenido.trim().equals("") && contenido.trim().length() > 0){
                    if(contenido.length() <= 200){
                        //es valido el tweet, se procede a crear
                        
                        int idTweet = ts.crearTweet(contenido, fn, isPublic, new Date(), usuarioLogueado);
                        allGood = true;

                        //luego de crear el tweet debemos de verificar si tiene HT y agregarlos a nuestra bdd de HT's
                        //HashtagServicio hs = new HashtagServicio();
                        hs.analizeTweet(idTweet);
                    }
                    else{
                        overSize = true;
                    }
                }
                else{
                    nullValues = true;
                }
            }
            else{
                notLogged = true;
            }
            if(notLogged){
                out.println("<p class=\"alert\"><span class=\"error\"></span><span class=\"error_text\">");
                out.println("Debes estar logueado para realizar esta accion...</span></p>");
                out.println("<a href=\"./index.jsp\">Volver atras...</a>");
            }
            else if(overSize){
                out.println("<p class=\"alert\"><span class=\"error\"></span><span class=\"error_text\">");
                out.println("El tweet debe contener no mas de 200 caracteres...</span></p>");
                out.println("<a href=\"./index.jsp\">Volver atras...</a>");
            }
            else if(nullValues){
                out.println("<p class=\"alert\"><span class=\"error\"></span><span class=\"error_text\">");
                out.println("Debe escribir por lo menos un caracter en el contenido..</span></p>");
                out.println("<a href=\"./index.jsp\">Volver atras...</a>");
            }
            if(allGood){
                response.sendRedirect("./index.jsp");
            }
            else
            {
                 response.sendRedirect("./index.jsp");
            }

        }
    }
    
    private String getFileName(Part part) {    
        for (String cd : part.getHeader("content-disposition").split(";")) { 
            if (cd.trim().startsWith("filename")) {       
                return cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");  
            }  
        }
        return null;
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
