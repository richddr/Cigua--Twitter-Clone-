<%-- 
    Document   : seguirUsuario
    Created on : Jul 2, 2014, 10:20:04 PM
    Author     : Richard
--%>

<%@page import="edu.pucmm.pw.parcial2.servicios.UsuarioServicio"%>
<%@page import="edu.pucmm.pw.parcial2.entidades.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
            <title>Seguir Usuario</title>
        </head>
        <body>
            <h1>Seguir Usuario</h1>
            <%
                boolean allGood = false;
                boolean noUserSpecified = false;
                boolean userNotLogged = false;
                boolean userDoesNotExist = false;
                UsuarioServicio us = new UsuarioServicio();
                
                //Usuario debe estar logueado....
                Usuario lu = (Usuario)request.getSession().getAttribute("usuarioLogueado");
                
                //recibimos el usuario a seguir por parametro...
                String username = request.getParameter("username");
                //Para ver que operacion es que se va a realizar
                String follow = request.getParameter("follow");
                String unfollow = request.getParameter("unfollow");
                if(lu != null){
                    if(username != null){
                        if(us.VerificarUsuario(username)){
                            if(follow != null){
                                allGood = us.followUsuario(lu.getUsername(), username);
                            }
                            else if(unfollow != null){
                                allGood = us.unfollowUsuario(lu.getUsername(), username);
                            }

                        }
                        else{
                            //no especifo usuario
                            userDoesNotExist = true;
                        }
                    }
                    else{
                        noUserSpecified = true;
                    } 
                }
                else{
                    userNotLogged = true;
                }
            %>
            <% if(userNotLogged){%>
            <p class="alert"><span class="error"></span><span class="error_text"> Debe estar logueado para realizar esta operacion...</span></p>
            <a href="./index.jsp">Inicio</a>
            <%}%>
            
            <% if(userDoesNotExist){%>
            <p class="alert"><span class="error"></span><span class="error_text"> El usuario que busca no existe...</span></p>
            <a href="./index.jsp">Inicio</a>
            <%}%>

            <% if(noUserSpecified){ %>
            <p class="alert"><span class="error"></span><span class="error_text">No se especifico el usuario a seguir..</span></p>
            <a href="<%=request.getServletPath()%>">Volver Atras...</a>
            <%}%>

            <% if(allGood){
                response.sendRedirect("./verPerfil.jsp?username=" + username);
            }
            %>
        </body>
    </html>
