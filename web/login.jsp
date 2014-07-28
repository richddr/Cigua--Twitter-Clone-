<%-- 
    Document   : login
    Created on : Jul 1, 2014, 6:55:59 PM
    Author     : Richard
--%>

<%@page import="edu.pucmm.pw.parcial2.entidades.Usuario"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="edu.pucmm.pw.parcial2.servicios.UsuarioServicio"%>
        <%
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            
            //se debe conectar a la bdd y verificar que el usuario existe o si introdujo la clave mal...
            UsuarioServicio us = new UsuarioServicio();
            int result = us.VerificarUsuario(username, password);
        %>
        <%if(result == 1){
            //datos validados correctamente, se agrega el usuario a la sesion logueado
            Usuario user = us.getUsuario(username);
            request.getSession().setAttribute("usuarioLogueado", user);
            response.sendRedirect("./index.jsp");
         }
        else{
            
            response.sendRedirect("./index.jsp?error=login");
        }%>
        
  