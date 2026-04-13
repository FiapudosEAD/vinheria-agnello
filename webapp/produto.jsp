<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Produto — Agnello</title>
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

<div class="breadcrumb">
  <a href="index.jsp">Início</a> <span>›</span> <a href="catalogo.jsp">Catálogo</a> <span>›</span> <span id="breadcrumb-name">Produto</span>
</div>

<section class="product-detail" style="padding: 2rem 4rem 5rem;">
  <div class="product-detail-grid" id="product-detail"></div>
</section>

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
      <h4>Contato</h4>
      <a href="#">contato@agnello.com.br</a>
      <a href="#">(54) 3000-0000</a>
    </div>
  </div>
  <div class="footer-bottom">
    <p>© 2026 Vinheria Agnello. Todos os direitos reservados.</p>
  </div>
</footer>

<script src="js/script.js"></script>
<script>
  const product = {
    id: ${vinho.id},
    name: `${vinho.nome}`,
    grape: `${vinho.uva}`,
    region: `${vinho.regiao}`,
    price: ${vinho.preco},
    type: `${vinho.tipo}`,
    stars: ${vinho.avaliacao},
    description: `${vinho.descricao}`,
    alcohol: `${vinho.teorAlcoolico}`,
    year: `${vinho.safra}`,
    aging: `${vinho.envelhecimento}`,
    temp: `${vinho.tempServico}`,
    pairing: `${vinho.harmonizacao}`
  };

  document.getElementById('breadcrumb-name').textContent = product.name;
  document.title = product.name + ' — Agnello';

  const bottleColor = product.type === 'branco' || product.type === 'espumante' ? '#8a9a4a' : '#4a0e1a';
  const bottleBodyColor = product.type === 'branco' ? '#8a9a4a' : product.type === 'espumante' ? '#6a7a3a' : '#3a0810';

  document.getElementById('product-detail').innerHTML = `
    <div class="product-detail-img">
      <svg class="bottle-svg" viewBox="0 0 100 300" fill="none" style="width:180px; opacity:0.4;">
        <rect x="40" y="0" width="20" height="28" rx="3" fill="\${bottleColor}"/>
        <path d="M35 28 Q20 55 20 95 L20 265 Q20 285 50 285 Q80 285 80 265 L80 95 Q80 55 65 28 Z" fill="\${bottleBodyColor}"/>
        <rect x="23" y="155" width="54" height="58" rx="2" fill="rgba(255,255,255,0.08)"/>
        <line x1="23" y1="235" x2="77" y2="235" stroke="rgba(200,169,110,0.5)" stroke-width="0.5"/>
        <line x1="23" y1="155" x2="77" y2="155" stroke="rgba(200,169,110,0.5)" stroke-width="0.5"/>
      </svg>
    </div>
    <div class="product-detail-info">
      <div class="section-label">\${product.region}</div>
      <div class="product-name">\${product.name}</div>
      <div class="product-grape">\${product.grape}</div>
      <div class="stars">\${'★'.repeat(product.stars)}\${'☆'.repeat(5-product.stars)}</div>
      <div class="product-price">R$ \${product.price.toFixed(2).replace('.',',')}</div>

      <div class="product-description">
        \${product.description}
      </div>

      <div class="product-specs-grid">
        <div class="product-spec">
          <div class="product-spec-val">\${product.alcohol}</div>
          <div class="product-spec-lbl">Vol. Álcool</div>
        </div>
        <div class="product-spec">
          <div class="product-spec-val">\${product.year}</div>
          <div class="product-spec-lbl">Safra</div>
        </div>
        <div class="product-spec">
          <div class="product-spec-val">\${product.aging}</div>
          <div class="product-spec-lbl">Envelhecimento</div>
        </div>
        <div class="product-spec">
          <div class="product-spec-val">\${product.temp}</div>
          <div class="product-spec-lbl">Temp. Serviço</div>
        </div>
      </div>

      <div class="product-actions">
        <div class="qty-control">
          <button onclick="changeQty(-1)">−</button>
          <span id="qty">1</span>
          <button onclick="changeQty(1)">+</button>
        </div>
        <button class="btn-primary" onclick="addToCartQty(\${product.id})">Adicionar ao Carrinho</button>
      </div>

      <div class="harmonization">
        <h4>Harmonização</h4>
        <p>\${product.pairing}</p>
      </div>
    </div>
  `;

  let qty = 1;
  function changeQty(delta) {
    qty = Math.max(1, qty + delta);
    document.getElementById('qty').textContent = qty;
  }
  function addToCartQty(id) {
    for (let i = 0; i < qty; i++) addToCart(id);
  }
</script>
</body>
</html>
