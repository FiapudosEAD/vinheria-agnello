<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  // Invalida a sessão do usuário
  session.invalidate();
  // Redireciona para a homepage
  response.sendRedirect("index.jsp");
%>
