<%-- 
    Document   : logout
    Created on : Jun 22, 2014, 5:59:54 PM
    Author     : Richard
--%>
        <%
            //debemos remover el logged user
            request.getSession().removeAttribute("usuarioLogueado");
            //request.getSession().invalidate();
            response.sendRedirect("./index.jsp");
        %>

