<html>
<head>
<title>
</title>
</head>
<body>
<%@ page import="jakarta.servlet.*, jakarta.servlet.http.*" %>
<%
    String id = request.getParameter("id");

    if (id != null && !id.isEmpty()) {
%>
        <form id="formConfirmar" action="cancelarReserva" method="post">
            <input type="hidden" name="id" value="<%= id %>" />
        </form>

        <script>
            document.getElementById("formConfirmar").submit(); // Envia automaticamente
        </script>
<%
    } else {
%>
        <p>ID da reserva não informado.</p>
<%
    }
%>

</body>
</html>