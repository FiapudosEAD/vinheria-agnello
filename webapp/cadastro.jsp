<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Criar Conta — Agnello</title>
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
      <h2>Junte-se à <em>família</em></h2>
      <p>Crie sua conta e descubra os melhores vinhos da Serra Gaúcha</p>
    </div>
  </div>

  <div class="auth-form-side">
    <div class="auth-form-container">
      <a href="index.jsp" class="logo" style="display:inline-block; margin-bottom:2rem; font-size:1.3rem;">
        Agnello
        <span>Vinheria · Est. 1987</span>
      </a>

      <div class="section-label">Nova Conta</div>
      <h2 class="section-title">Criar sua <em>conta</em></h2>

      <c:if test="${not empty erro}">
        <div class="alert alert-danger">${erro}</div>
      </c:if>

      <form action="CadastroServlet" method="post">
        <div class="form-row">
          <div class="form-group">
            <label for="nome">Nome</label>
            <input type="text" id="nome" name="nome" placeholder="Seu nome" required
                   value="${not empty param.nome ? param.nome : ''}" />
          </div>
          <div class="form-group">
            <label for="sobrenome">Sobrenome</label>
            <input type="text" id="sobrenome" name="sobrenome" placeholder="Seu sobrenome" required
                   value="${not empty param.sobrenome ? param.sobrenome : ''}" />
          </div>
        </div>

        <div class="form-group">
          <label for="email">E-mail</label>
          <input type="email" id="email" name="email" placeholder="seu@email.com" required
                 value="${not empty param.email ? param.email : ''}" />
        </div>

        <div class="form-group">
          <label for="dataNascimento">Data de Nascimento</label>
          <input type="date" id="dataNascimento" name="dataNascimento" required
                 value="${not empty param.dataNascimento ? param.dataNascimento : ''}" />
        </div>

        <div class="form-row">
          <div class="form-group">
            <label for="senha">Senha</label>
            <input type="password" id="senha" name="senha" placeholder="Min. 6 caracteres" required minlength="6" />
          </div>
          <div class="form-group">
            <label for="confirmarSenha">Confirmar Senha</label>
            <input type="password" id="confirmarSenha" name="confirmarSenha" placeholder="Repita a senha" required />
          </div>
        </div>

        <div class="form-actions">
          <button type="submit" class="btn-primary">Criar Conta</button>
        </div>
      </form>

      <div class="form-link">
        Já tem conta? <a href="login.jsp">Entrar</a>
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

  document.querySelector('form').addEventListener('submit', function(e) {
    const senha = document.getElementById('senha').value;
    const confirmar = document.getElementById('confirmarSenha').value;
    if (senha !== confirmar) {
      e.preventDefault();
      alert('As senhas não coincidem!');
    }
  });
</script>
</body>
</html>
