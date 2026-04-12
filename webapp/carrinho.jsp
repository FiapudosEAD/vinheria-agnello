<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Carrinho — Agnello</title>
  <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,600;1,300;1,400&family=Cinzel:wght@400;600&family=Jost:wght@300;400&display=swap" rel="stylesheet"/>
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div id="cursor"></div>
<div id="cursor-ring"></div>
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
  </nav>
</header>

<div class="breadcrumb">
  <a href="index.jsp">Início</a> <span>›</span> Carrinho
</div>

<section class="cart-page" style="padding: 2rem 4rem 5rem;">
  <div class="section-label">Seu carrinho</div>
  <h2 class="section-title" style="margin-bottom: 3rem;">Finalize sua <em>seleção</em></h2>

  <div id="cart-page-content">
    <%-- Conteúdo carregado via JavaScript --%>
  </div>
</section>

<footer>
  <div class="footer-top">
    <div class="footer-brand">
      <a href="index.jsp" class="logo">Agnello</a>
      <p>Vinheria familiar desde 1987.</p>
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
  function renderCartPage() {
    const container = document.getElementById('cart-page-content');
    if (cart.length === 0) {
      container.innerHTML = `
        <div style="text-align:center; padding:4rem 0;">
          <p style="font-family:'Cormorant Garamond',serif; font-size:1.5rem; font-style:italic; color:var(--text-light); margin-bottom:2rem;">
            Seu carrinho está vazio
          </p>
          <a href="catalogo.jsp" class="btn-primary">Explorar Vinhos</a>
        </div>`;
      return;
    }

    let tableRows = cart.map(item => {
      const bottleColor = item.type === 'tinto' ? '#3a0810' : '#6a8a3a';
      const capColor = item.type === 'tinto' ? '#4a0e1a' : '#8a9a4a';
      return `
        <tr>
          <td>
            <div class="cart-product-info">
              <div class="cart-product-thumb">
                <svg class="bottle-svg" viewBox="0 0 100 300" fill="none">
                  <rect x="40" y="0" width="20" height="28" rx="3" fill="\${capColor}"/>
                  <path d="M35 28 Q20 55 20 95 L20 265 Q20 285 50 285 Q80 285 80 265 L80 95 Q80 55 65 28 Z" fill="\${bottleColor}"/>
                </svg>
              </div>
              <div>
                <div class="cart-product-name">\${item.name}</div>
                <div class="cart-product-grape">\${item.grape}</div>
              </div>
            </div>
          </td>
          <td style="font-family:'Cormorant Garamond',serif; font-size:1.2rem;">R$ \${item.price.toFixed(2).replace('.',',')}</td>
          <td>
            <div class="qty-control">
              <button onclick="updateCartQty(\${item.id}, -1)">−</button>
              <span>\${item.qty}</span>
              <button onclick="updateCartQty(\${item.id}, 1)">+</button>
            </div>
          </td>
          <td style="font-family:'Cormorant Garamond',serif; font-size:1.2rem; color:var(--burgundy);">
            R$ \${(item.price * item.qty).toFixed(2).replace('.',',')}
          </td>
          <td>
            <button class="btn-danger" onclick="removeFromCart(\${item.id})">Remover</button>
          </td>
        </tr>`;
    }).join('');

    const subtotal = cart.reduce((a, x) => a + x.price * x.qty, 0);
    const frete = subtotal >= 350 ? 0 : 25;
    const total = subtotal + frete;

    container.innerHTML = `
      <table class="cart-table">
        <thead>
          <tr>
            <th>Produto</th>
            <th>Preço</th>
            <th>Quantidade</th>
            <th>Subtotal</th>
            <th></th>
          </tr>
        </thead>
        <tbody>\${tableRows}</tbody>
      </table>
      <div class="cart-summary">
        <div class="cart-summary-row">
          <span>Subtotal</span>
          <span>R$ \${subtotal.toFixed(2).replace('.',',')}</span>
        </div>
        <div class="cart-summary-row">
          <span>Frete</span>
          <span>\${frete === 0 ? 'Grátis' : 'R$ ' + frete.toFixed(2).replace('.',',')}</span>
        </div>
        <div class="cart-summary-row total">
          <span>Total</span>
          <span>R$ \${total.toFixed(2).replace('.',',')}</span>
        </div>
        <button class="btn-primary" style="width:100%; margin-top:1.5rem; text-align:center;"
                onclick="finalizarCompra()">
          Finalizar Compra
        </button>
      </div>`;
  }

  function updateCartQty(id, delta) {
    const item = cart.find(x => x.id === id);
    if (item) {
      item.qty += delta;
      if (item.qty <= 0) cart = cart.filter(x => x.id !== id);
      updateCart();
      renderCartPage();
    }
  }

  function removeFromCart(id) {
    cart = cart.filter(x => x.id !== id);
    updateCart();
    renderCartPage();
    showToast('Item removido do carrinho');
  }

  function finalizarCompra() {
    <%-- Verifica se está logado via JSP --%>
    <c:choose>
      <c:when test="${not empty sessionScope.usuarioLogado}">
        showToast('Compra finalizada com sucesso!');
        cart = [];
        updateCart();
        setTimeout(() => { renderCartPage(); }, 1500);
      </c:when>
      <c:otherwise>
        window.location.href = 'login.jsp';
      </c:otherwise>
    </c:choose>
  }

  renderCartPage();
</script>
</body>
</html>
