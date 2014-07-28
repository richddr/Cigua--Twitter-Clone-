/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package edu.pucmm.pw.parcial2.servlets;

import edu.pucmm.pw.parcial2.servicios.UsuarioServicio;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
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
@WebServlet(name = "crearUsuario", urlPatterns = {"/crearUsuario", "/cu"})
public class crearUsuario extends HttpServlet {

    @Inject
    UsuarioServicio us;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.text.ParseException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */

            boolean allGood = false;
            boolean missingData = false;
            boolean primaryKeyError = false;
            boolean datewrong = false;
            //if(request.getMethod().equalsIgnoreCase("POST")){
            //UsuarioServicio us = new UsuarioServicio();
            //obtenemos los valores del form...
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String nombre = request.getParameter("nombre");
            String apellido = request.getParameter("apellido");
            String fechaNacimiento = request.getParameter("fechaNacimiento");//se debe de instanciar como new Date
            //out.println(us.probando());
            //manejando el archivo:

            Part fotoUsuario = request.getPart("fotoUsuario");
            String fn = null;
            if (fotoUsuario != null && fotoUsuario.getSize() > 0) {
                InputStream isfotoUsuario = fotoUsuario.getInputStream();

                fn = getFileName(fotoUsuario);
                String of = this.getServletContext().getRealPath(fn);
                FileOutputStream os = new FileOutputStream(of);

                    // write bytes taken from uploaded file to target file
                //se escriben los bytes del archivo subido al archivo destino en el servidor...
                int ch = isfotoUsuario.read();
                long archiTam = 0;//para contar los bytes del archivo...
                while (ch != -1) {
                    os.write(ch);
                    ch = isfotoUsuario.read();
                    archiTam++;
                }
            }
           // out.println(fechaNacimiento);
            Date fec;
            // out.println(fechaNacimiento);
            if (!fechaNacimiento.equals("")) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                fec = sdf.parse(fechaNacimiento);

                if (username != null && password != null & nombre != null) {
                    
                    if(username.trim().length() > 0 && password.trim().length() > 0 && nombre.trim().length() > 0)
                    {
                    //verificamos que ese username no este siendo utilizado ya...
                    if (!us.VerificarUsuario(username)) {
                        //usuario no existe se procede a crear
                        us.crearUsuario(username, password, nombre, apellido, fec, fn);
                        allGood = true;

                        //ya creado se agrega ese usuario a la session...
                        request.getSession().setAttribute("usuarioLogueado", us.getUsuario(username));
                    } else {
                        primaryKeyError = true;
                    }
                    }
                    else
                    {
                    missingData = true;
                    }
                } else {
                    //debe especificar al menos un usuario y contraseña...
                    missingData = true;
                }

            } else {
                datewrong = true;
            }
            //}
            if (primaryKeyError) {
                response.sendRedirect("./index.jsp?error=useduser");

            }

            if (datewrong) {
                response.sendRedirect("./index.jsp?error=datewrong");

            }
            if (missingData) {
                response.sendRedirect("./index.jsp?error=notext");
            }
            if (allGood) {
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
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(crearUsuario.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(crearUsuario.class.getName()).log(Level.SEVERE, null, ex);
        }
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
