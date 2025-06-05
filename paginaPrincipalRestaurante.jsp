<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Painel do Restaurante</title>
</head>
<body>
    <h1>Bem-vindo ao Painel do Restaurante</h1>

    <%
        String nome = (String) session.getAttribute("nome");
        String cnpj = (String) session.getAttribute("cnpj");

        if (nome != null && cnpj != null) {
    %>
        <p><strong>Nome do Restaurante:</strong> <%= nome %></p>
        <p><strong>CNPJ:</strong> <%= cnpj %></p>
        <a href="logout">Sair</a>
        
    <%
        } else {
    %>
        <p>Erro: Sessão expirada ou não logado. <a href="login_restaurante.jsp">Fazer login</a></p>
    <%
        }
    %>
</body>
</html>
