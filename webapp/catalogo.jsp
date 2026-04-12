<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Catálogo — Agnello</title>
  <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,600;1,300;1,400&family=Cinzel:wght@400;600&family=Jost:wght@300;400&display=swap" rel="stylesheet"/>
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div id="cursor"></div>
<div id="cursor-ring"></div>

<div class="cart-overlay" id="cart-overlay" onclick="closeCart()"></div>
<div id="cart-sidebar">
  <div class="cart-header">
    <h3>Sua seleção <span class="cart-count" id="cart-count">0</span></h3>
    <button class="cart-close" onclick="closeCart()">✕</button>
  </div>
  <div class="cart-items" id="cart-items">
    <div class="empty-cart">Seu carrinho está vazio</div>
  </div>
  <div class="cart-footer">
    <div class="cart-total">
      <span>Total</span>
      <span id="cart-total">R$ 0,00</span>
    </div>
    <a href="carrinho.jsp" class="checkout-btn">Finalizar Compra</a>
  </div>
</div>
<div class="toast" id="toast"></div>

<!-- Header (escuro fixo) -->
<header id="header" class="header-dark">
  <a href="index.jsp" class="logo">
    Agnello
    <span>Vinheria · Est. 1987</span>
  </a>
  <nav>
    <a href="catalogo.jsp">Vinhos</a>
    <a href="index.jsp#about">A Vinheria</a>
    <c:choose>
      <c:when test="${not empty sessionScope.usuarioLogado}">
        <span class="user-badge">${sessionScope.usuarioLogado.nome}</span>
        <a href="logout.jsp">Sair</a>
      </c:when>
      <c:otherwise>
        <a href="login.jsp">Entrar</a>
      </c:otherwise>
    </c:choose>
    <button class="cart-btn" onclick="openCart()">Carrinho <span class="cart-count" id="cart-count-header">0</span></button>
  </nav>
</header>

<!-- Breadcrumb -->
<div class="breadcrumb">
  <a href="index.jsp">Início</a> <span>›</span> Catálogo de Vinhos
</div>

<!-- Catálogo completo -->
<section id="collections" style="padding-top: 2rem;">
  <div class="collections-header reveal">
    <div>
      <div class="section-label">Nossa Adega</div>
      <h2 class="section-title">Catálogo <em>Completo</em></h2>
    </div>
    <div class="filter-tabs">
      <button class="filter-tab active" onclick="filterProducts('todos', this)">Todos</button>
      <button class="filter-tab" onclick="filterProducts('tinto', this)">Tintos</button>
      <button class="filter-tab" onclick="filterProducts('branco', this)">Brancos</button>
      <button class="filter-tab" onclick="filterProducts('espumante', this)">Espumantes</button>
      <button class="filter-tab" onclick="filterProducts('rose', this)">Rosés</button>
    </div>
  </div>
  <div class="products-grid" id="products-grid"></div>
</section>

<!-- Footer -->
<footer>
  <div class="footer-top">
    <div class="footer-brand">
      <a href="index.jsp" class="logo">Agnello</a>
      <p>Vinheria familiar desde 1987.</p>
    </div>
    <div class="footer-col">
      <h4>Vinhos</h4>
      <a href="catalogo.jsp">Tintos</a>
      <a href="catalogo.jsp">Brancos</a>
      <a href="catalogo.jsp">Espumantes</a>
    </div>
    <div class="footer-col">
      <h4>Vinheria</h4>
      <a href="index.jsp#about">Nossa História</a>
      <a href="#">Prêmios</a>
    </div>
    <div class="footer-col">
      <h4>Contato</h4>
      <a href="#">contato@agnello.com.br</a>
      <a href="#">(54) 3000-0000</a>
    </div>
  </div>
  <div class="footer-bottom">
    <p>© 2026 Vinheria Agnello. Todos os direitos reservados.</p>
    <div class="socials">
      <a href="#" class="social-link">ig</a>
      <a href="#" class="social-link">fb</a>
    </div>
  </div>
</footer>

<script src="js/script.js"></script>
</body>
</html>
