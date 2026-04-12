<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Agnello — Vinheria</title>
  <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,600;1,300;1,400&family=Cinzel:wght@400;600&family=Jost:wght@300;400&display=swap" rel="stylesheet"/>
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div id="cursor"></div>
<div id="cursor-ring"></div>

<!-- Cart Overlay -->
<div class="cart-overlay" id="cart-overlay" onclick="closeCart()"></div>

<!-- Cart Sidebar -->
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

<!-- Header -->
<header id="header">
  <a href="index.jsp" class="logo">
    Agnello
    <span>Vinheria · Est. 1987</span>
  </a>
  <nav>
    <a href="catalogo.jsp">Vinhos</a>
    <a href="#feature">Destaque</a>
    <a href="#about">A Vinheria</a>
    <a href="#testimonials">Avaliações</a>
    <a href="#newsletter">Contato</a>

    <%-- Exibe botão de login OU nome do usuário logado --%>
    <c:choose>
      <c:when test="${not empty sessionScope.usuarioLogado}">
        <span class="user-badge">${sessionScope.usuarioLogado.nome}</span>
        <a href="logout.jsp" style="margin-left:1rem;">Sair</a>
      </c:when>
      <c:otherwise>
        <a href="login.jsp">Entrar</a>
      </c:otherwise>
    </c:choose>

    <button class="cart-btn" onclick="openCart()">Carrinho <span class="cart-count" id="cart-count-header">0</span></button>
  </nav>
</header>

<!-- Hero -->
<section id="hero">
  <div class="hero-bg">
    <div class="vine-left"></div>
    <div class="vine-right"></div>
  </div>
  <div class="hero-content">
    <div class="hero-badge">Seleção Premium · Safra 2024</div>
    <h1 class="hero-title">
      Vinho que<br>
      conta <em>histórias</em>
    </h1>
    <p class="hero-sub">Da vinha à taça, com paixão e tradição desde 1987</p>
    <div class="hero-cta">
      <a href="catalogo.jsp" class="btn-primary">Explorar Vinhos</a>
      <a href="#about" class="btn-outline">Nossa História</a>
    </div>
  </div>
  <div class="scroll-hint">
    <div class="scroll-line"></div>
    Rolar
  </div>
</section>

<!-- Strip -->
<div class="strip">
  <div class="strip-item">Frete grátis acima de R$ 350</div>
  <div class="strip-item">Mais de 35 anos de tradição</div>
  <div class="strip-item">Vinhos premiados internacionalmente</div>
  <div class="strip-item">Embalagem exclusiva para presente</div>
</div>

<!-- Collections (Catálogo resumido) -->
<section id="collections">
  <div class="collections-header reveal">
    <div>
      <div class="section-label">Nossa Adega</div>
      <h2 class="section-title">Coleção <em>Agnello</em></h2>
    </div>
    <div class="filter-tabs">
      <button class="filter-tab active" onclick="filterProducts('todos', this)">Todos</button>
      <button class="filter-tab" onclick="filterProducts('tinto', this)">Tintos</button>
      <button class="filter-tab" onclick="filterProducts('branco', this)">Brancos</button>
      <button class="filter-tab" onclick="filterProducts('espumante', this)">Espumantes</button>
    </div>
  </div>
  <div class="products-grid" id="products-grid">
    <%-- Produtos carregados via JavaScript (mesma lógica do Sprint 1) --%>
  </div>
</section>

<!-- Feature -->
<section id="feature">
  <div class="feature-img">
    <svg class="big-bottle" viewBox="0 0 100 300" fill="none" xmlns="http://www.w3.org/2000/svg">
      <rect x="40" y="0" width="20" height="30" rx="3" fill="#c8a96e" opacity="0.8"/>
      <path d="M35 30 Q20 60 20 100 L20 270 Q20 290 50 290 Q80 290 80 270 L80 100 Q80 60 65 30 Z" fill="#4a0e1a"/>
      <path d="M35 30 Q20 60 20 100 L20 140 Q30 110 50 110 Q70 110 80 140 L80 100 Q80 60 65 30 Z" fill="#3a0a14"/>
      <rect x="22" y="160" width="56" height="60" rx="2" fill="#c8a96e" opacity="0.25"/>
      <text x="50" y="185" font-family="serif" font-size="6" fill="#c8a96e" text-anchor="middle" opacity="0.9">AGNELLO</text>
      <text x="50" y="196" font-family="sans-serif" font-size="4" fill="#c8a96e" text-anchor="middle" opacity="0.7">RESERVA ESPECIAL</text>
      <text x="50" y="208" font-family="serif" font-size="4" fill="#c8a96e" text-anchor="middle" opacity="0.6">2019</text>
    </svg>
  </div>
  <div class="feature-text">
    <div class="section-label reveal">Destaque da Safra</div>
    <h2 class="section-title reveal reveal-delay-1">Reserva <em>Especial</em><br>Agnello 2019</h2>
    <p class="reveal reveal-delay-2">
      Uma safra excepcional das altitudes da Serra Gaúcha. Cor rubi profunda,
      com aromas de frutas negras, especiarias e toque de carvalho francês.
      Estruturado, elegante, com final longo e aveludado.
    </p>
    <a href="produto.jsp?id=1" class="btn-primary reveal reveal-delay-3">Ver Detalhes</a>
    <div class="feature-specs reveal reveal-delay-4">
      <div class="spec">
        <div class="spec-val">94</div>
        <div class="spec-lbl">Pontos Robert Parker</div>
      </div>
      <div class="spec">
        <div class="spec-val">18</div>
        <div class="spec-lbl">Meses em Carvalho</div>
      </div>
      <div class="spec">
        <div class="spec-val">13,5%</div>
        <div class="spec-lbl">Vol. Álcool</div>
      </div>
    </div>
  </div>
</section>

<!-- About -->
<section id="about">
  <div class="about-visual reveal">
    <div class="about-img">
      <svg width="90" height="200" viewBox="0 0 100 300" fill="none" opacity="0.4">
        <rect x="40" y="0" width="20" height="30" rx="3" fill="#c8a96e"/>
        <path d="M35 30 Q20 60 20 100 L20 270 Q20 290 50 290 Q80 290 80 270 L80 100 Q80 60 65 30 Z" fill="#c8a96e" opacity="0.5"/>
      </svg>
    </div>
  </div>
  <div class="about-text reveal reveal-delay-2">
    <div class="section-label">Sobre Nós</div>
    <h2 class="section-title">Tradição que se <em>herda</em>, sabor que se aprende</h2>
    <blockquote>
      "O vinho é a poesia da terra — cada garrafa guarda a alma de quem a cultivou."
    </blockquote>
    <p>
      A Vinheria Agnello nasceu em 1987 nas encostas da Serra Gaúcha, quando a família
      Agnello decidiu transformar décadas de tradição vinícola italiana em uma proposta
      autenticamente brasileira.
    </p>
    <p>
      Hoje, com mais de 30 variedades cultivadas em altitude superior a 700 metros,
      produzimos vinhos que expressam o terroir único da região — distinguidos por sua
      acidez equilibrada, complexidade aromática e longevidade extraordinária.
    </p>
    <a href="catalogo.jsp" class="btn-primary">Descobrir os Vinhos</a>
  </div>
</section>

<!-- Testimonials -->
<section id="testimonials">
  <div class="section-label reveal" style="color:var(--gold);">O Que Dizem</div>
  <h2 class="section-title reveal reveal-delay-1" style="color:var(--cream);">Avaliações de <em style="color:var(--gold);">Apreciadores</em></h2>
  <div class="testimonials-grid">
    <div class="testimonial-card reveal reveal-delay-1">
      <p>Um Cabernet que rivaliza com os melhores da América do Sul. Cor densa, taninos sedosos e um final que dura minutos. Simplesmente sublime.</p>
      <div class="testimonial-author">Carlos Menezes</div>
      <div class="testimonial-location">São Paulo, SP</div>
    </div>
    <div class="testimonial-card reveal reveal-delay-2">
      <p>Recebi a caixa como presente e fiquei encantada com a apresentação. O Chardonnay Agnello é refrescante, com mineralidade que poucos vinhos nacionais têm.</p>
      <div class="testimonial-author">Fernanda Oliveira</div>
      <div class="testimonial-location">Rio de Janeiro, RJ</div>
    </div>
    <div class="testimonial-card reveal reveal-delay-3">
      <p>Encomendo a cada trimestre há três anos. A consistência e qualidade são impressionantes. O Espumante Brut é meu favorito para celebrações especiais.</p>
      <div class="testimonial-author">Ricardo Amaral</div>
      <div class="testimonial-location">Curitiba, PR</div>
    </div>
  </div>
</section>

<!-- Newsletter -->
<section id="newsletter">
  <div class="section-label reveal">Fique por Dentro</div>
  <h2 class="section-title reveal reveal-delay-1">Receba nossas <em>novidades</em></h2>
  <p class="reveal reveal-delay-2">Novas safras, eventos exclusivos e ofertas especiais direto na sua caixa de entrada.</p>
  <form class="newsletter-form reveal reveal-delay-3" onsubmit="handleNewsletter(event)">
    <input type="email" placeholder="seu@email.com" required />
    <button type="submit">Inscrever</button>
  </form>
</section>

<!-- Footer -->
<footer>
  <div class="footer-top">
    <div class="footer-brand">
      <a href="index.jsp" class="logo">Agnello</a>
      <p>Vinheria familiar desde 1987. Produzimos vinhos que carregam a alma da Serra Gaúcha em cada garrafa.</p>
    </div>
    <div class="footer-col">
      <h4>Vinhos</h4>
      <a href="catalogo.jsp">Tintos</a>
      <a href="catalogo.jsp">Brancos</a>
      <a href="catalogo.jsp">Rosés</a>
      <a href="catalogo.jsp">Espumantes</a>
    </div>
    <div class="footer-col">
      <h4>Vinheria</h4>
      <a href="#about">Nossa História</a>
      <a href="#">Sustentabilidade</a>
      <a href="#">Prêmios</a>
      <a href="#">Visitas à Vinícola</a>
    </div>
    <div class="footer-col">
      <h4>Contato</h4>
      <a href="#">contato@agnello.com.br</a>
      <a href="#">(54) 3000-0000</a>
      <a href="#">Serra Gaúcha, RS</a>
      <a href="#">Seg–Sex 9h–18h</a>
    </div>
  </div>
  <div class="footer-bottom">
    <p>© 2026 Vinheria Agnello. Todos os direitos reservados. Beba com moderação.</p>
    <div class="socials">
      <a href="#" class="social-link">ig</a>
      <a href="#" class="social-link">fb</a>
      <a href="#" class="social-link">yt</a>
    </div>
  </div>
</footer>

<script src="js/script.js"></script>
</body>
</html>
