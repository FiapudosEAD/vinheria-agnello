<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Entrar — Agnello</title>
  <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,600;1,300;1,400&family=Cinzel:wght@400;600&family=Jost:wght@300;400&display=swap" rel="stylesheet"/>
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div id="cursor"></div>
<div id="cursor-ring"></div>

<div class="auth-page">
  <div class="auth-visual">
    <div class="auth-visual-content">
      <svg width="80" height="180" viewBox="0 0 100 300" fill="none" opacity="0.3" style="margin-bottom:2rem;">
        <rect x="40" y="0" width="20" height="30" rx="3" fill="#c8a96e"/>
        <path d="M35 30 Q20 60 20 100 L20 270 Q20 290 50 290 Q80 290 80 270 L80 100 Q80 60 65 30 Z" fill="#c8a96e" opacity="0.5"/>
      </svg>
      <h2>Bem-vindo de <em>volta</em></h2>
      <p>Entre para acessar sua adega pessoal e ofertas exclusivas</p>
    </div>
  </div>

  <div class="auth-form-side">
    <div class="auth-form-container">
      <a href="index.jsp" class="logo" style="display:inline-block; margin-bottom:2rem; font-size:1.3rem;">
        Agnello
        <span>Vinheria · Est. 1987</span>
      </a>

      <div class="section-label">Acesso</div>
      <h2 class="section-title">Entrar na sua <em>conta</em></h2>

      <c:if test="${not empty erro}">
        <div class="alert alert-danger">${erro}</div>
      </c:if>
      <c:if test="${not empty sucesso}">
        <div class="alert alert-success">${sucesso}</div>
      </c:if>

      <form action="LoginServlet" method="post">
        <div class="form-group">
          <label for="email">E-mail</label>
          <input type="email" id="email" name="email" placeholder="seu@email.com" required
                 value="${not empty param.email ? param.email : ''}" />
        </div>

        <div class="form-group">
          <label for="senha">Senha</label>
          <input type="password" id="senha" name="senha" placeholder="Sua senha" required />
        </div>

        <div class="form-actions">
          <button type="submit" class="btn-primary">Entrar</button>
        </div>
      </form>

      <div class="form-link">
        Não tem conta? <a href="cadastro.jsp">Criar conta</a>
      </div>
    </div>
  </div>
</div>

<script>
  const cur = document.getElementById('cursor');
  const ring = document.getElementById('cursor-ring');
  document.addEventListener('mousemove', e => {
    cur.style.left = e.clientX + 'px';
    cur.style.top  = e.clientY + 'px';
    ring.style.left = e.clientX + 'px';
    ring.style.top  = e.clientY + 'px';
  });
</script>
</body>
</html>
