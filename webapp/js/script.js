/* ============================================
   VINHERIA AGNELLO — JavaScript (Sprint 2)
   ============================================ */

// --- Custom Cursor ---
const cur = document.getElementById('cursor');
const ring = document.getElementById('cursor-ring');
if (cur && ring) {
  document.addEventListener('mousemove', e => {
    cur.style.left = e.clientX + 'px';
    cur.style.top  = e.clientY + 'px';
    ring.style.left = e.clientX + 'px';
    ring.style.top  = e.clientY + 'px';
  });
}

// --- Header scroll ---
const hdr = document.getElementById('header');
if (hdr && !hdr.classList.contains('header-dark')) {
  window.addEventListener('scroll', () => {
    hdr.classList.toggle('scrolled', window.scrollY > 60);
  });
}

// --- Reveal on scroll ---
const observer = new IntersectionObserver(entries => {
  entries.forEach(e => { if (e.isIntersecting) e.target.classList.add('visible'); });
}, { threshold: 0.12 });
document.querySelectorAll('.reveal').forEach(el => observer.observe(el));

// --- Products Data (simulando o que viria do banco de dados) ---
const products = [
  {
    id: 1, name: 'Cabernet Sauvignon Reserva', grape: 'Cabernet Sauvignon',
    region: 'Serra Gaúcha, RS', price: 189, type: 'tinto',
    badge: 'Mais Vendido', stars: 5,
    description: 'Um Cabernet de altitude com corpo robusto e taninos elegantes. Notas de cassis, amora e um toque de baunilha proveniente dos 18 meses em barris de carvalho francês. Final longo e sofisticado.',
    alcohol: '13,5%', year: '2019', aging: '18 meses', temp: '16–18°C',
    pairing: 'Filé mignon ao molho madeira, cordeiro assado, queijos curados como parmesão e pecorino.'
  },
  {
    id: 2, name: 'Merlot Gran Seleção', grape: 'Merlot',
    region: 'Vale dos Vinhedos, RS', price: 149, type: 'tinto',
    badge: '', stars: 4,
    description: 'Merlot de corpo médio, aveludado e frutado. Aromas de ameixa madura, cereja e notas herbáceas sutis. Perfeito para quem busca um tinto acessível e versátil.',
    alcohol: '13%', year: '2021', aging: '10 meses', temp: '16–18°C',
    pairing: 'Massas com molho de tomate, pizzas artesanais, carnes brancas grelhadas.'
  },
  {
    id: 3, name: 'Chardonnay Signature', grape: 'Chardonnay',
    region: 'Farroupilha, RS', price: 129, type: 'branco',
    badge: 'Novo', stars: 5,
    description: 'Chardonnay de altitude com mineralidade marcante e frescor vibrante. Aromas de maçã verde, pêssego branco e leve tostado. Fermentação parcial em barricas confere complexidade.',
    alcohol: '12,5%', year: '2023', aging: '6 meses', temp: '8–10°C',
    pairing: 'Frutos do mar, salmão grelhado, risotos cremosos e saladas com queijo de cabra.'
  },
  {
    id: 4, name: 'Pinot Noir Altitude', grape: 'Pinot Noir',
    region: 'São Joaquim, SC', price: 219, type: 'tinto',
    badge: 'Premiado', stars: 5,
    description: 'Pinot Noir excepcional, cultivado a 1.400m de altitude. Cor rubi translúcida, aromas delicados de cereja, framboesa e pétalas de rosa. Elegante, com acidez vibrante e final sedoso.',
    alcohol: '12,8%', year: '2020', aging: '14 meses', temp: '14–16°C',
    pairing: 'Pato confitado, cogumelos salteados, queijo brie e salmão defumado.'
  },
  {
    id: 5, name: 'Sauvignon Blanc Estate', grape: 'Sauvignon Blanc',
    region: 'Serra Gaúcha, RS', price: 115, type: 'branco',
    badge: '', stars: 4,
    description: 'Sauvignon Blanc refrescante e aromático. Notas cítricas de limão siciliano e maracujá, com fundo herbal. Vinificação em aço inox preserva toda a vivacidade da uva.',
    alcohol: '12%', year: '2023', aging: 'Inox', temp: '6–8°C',
    pairing: 'Ceviche, ostras, saladas frescas e sushi.'
  },
  {
    id: 6, name: 'Espumante Brut Natura', grape: 'Chardonnay / Pinot Noir',
    region: 'Garibaldi, RS', price: 135, type: 'espumante',
    badge: 'Favorito', stars: 5,
    description: 'Espumante Brut elaborado pelo método Champenoise com 24 meses sobre borras. Perlage fino e persistente, aromas de brioche, maçã e amêndoas. Perfeito para celebrações.',
    alcohol: '12%', year: '2021', aging: '24 meses', temp: '4–6°C',
    pairing: 'Canapés, frutos do mar, pratos leves e sobremesas com frutas cítricas.'
  },
  {
    id: 7, name: 'Tannat Barrique', grape: 'Tannat',
    region: 'Candiota, RS', price: 175, type: 'tinto',
    badge: '', stars: 4,
    description: 'Tannat encorpado e potente, com taninos firmes e cor violácea intensa. Aromas de amora, tabaco e especiarias escuras. Envelhecimento em barricas de carvalho americano.',
    alcohol: '14%', year: '2020', aging: '12 meses', temp: '16–18°C',
    pairing: 'Costela no bafo, churrasco, feijoada e queijos azuis como gorgonzola.'
  },
  {
    id: 8, name: 'Moscatel Rosé', grape: 'Moscato Rosa',
    region: 'Serra Gaúcha, RS', price: 99, type: 'espumante',
    badge: '', stars: 4,
    description: 'Moscatel rosado doce e aromático, com intensa fragrância de rosas, lichia e uva fresca. Leve e refrescante, com doçura equilibrada.',
    alcohol: '7,5%', year: '2023', aging: 'Charmat', temp: '4–6°C',
    pairing: 'Sobremesas com frutas vermelhas, bolos, tortas e aperitivo.'
  },
  {
    id: 9, name: 'Rosé Provence Style', grape: 'Merlot / Cabernet',
    region: 'Serra Gaúcha, RS', price: 109, type: 'rose',
    badge: 'Novo', stars: 4,
    description: 'Rosé de cor salmão pálido, inspirado nos vinhos da Provence. Aromas delicados de morango, pêssego e flores brancas. Leve, seco e extremamente refrescante.',
    alcohol: '11,5%', year: '2023', aging: 'Inox', temp: '8–10°C',
    pairing: 'Saladas mediterrâneas, frutos do mar, bruschettas e queijos frescos.'
  },
  {
    id: 10, name: 'Gewürztraminer Colheita Tardia', grape: 'Gewürztraminer',
    region: 'Pinto Bandeira, RS', price: 165, type: 'branco',
    badge: 'Raro', stars: 5,
    description: 'Gewürztraminer de colheita tardia com concentração aromática extraordinária. Notas de lichia, mel, gengibre e pétalas de rosa. Doçura refinada equilibrada por acidez vibrante.',
    alcohol: '13%', year: '2022', aging: '8 meses', temp: '8–10°C',
    pairing: 'Foie gras, queijos azuis, comida tailandesa e sobremesas com frutas tropicais.'
  }
];

// --- Cart (persistido no localStorage) ---
let cart = JSON.parse(localStorage.getItem('agnello_cart') || '[]');
let activeFilter = 'todos';

function saveCart() {
  localStorage.setItem('agnello_cart', JSON.stringify(cart));
}

function filterProducts(type, btn) {
  activeFilter = type;
  document.querySelectorAll('.filter-tab').forEach(t => t.classList.remove('active'));
  btn.classList.add('active');
  renderProducts();
}

function renderProducts() {
  const grid = document.getElementById('products-grid');
  if (!grid) return;

  const filtered = activeFilter === 'todos'
    ? products
    : products.filter(p => p.type === activeFilter);

  grid.innerHTML = filtered.map(p => {
    const capColor = (p.type === 'branco' || p.type === 'espumante') ? '#9aaa6a' : '#4a0e1a';
    const bodyColor = p.type === 'branco' ? '#8a9a4a' : p.type === 'espumante' ? '#6a7a3a' : p.type === 'rose' ? '#c47a7a' : '#3a0810';

    return `
      <div class="product-card reveal visible">
        ${p.badge ? `<div class="product-badge">${p.badge}</div>` : ''}
        <a href="produto.jsp?id=${p.id}" style="text-decoration:none; color:inherit;">
          <div class="product-img-wrap">
            <svg class="bottle-svg" viewBox="0 0 100 300" fill="none">
              <rect x="40" y="0" width="20" height="28" rx="3" fill="${capColor}"/>
              <path d="M35 28 Q20 55 20 95 L20 265 Q20 285 50 285 Q80 285 80 265 L80 95 Q80 55 65 28 Z" fill="${bodyColor}"/>
              <rect x="23" y="155" width="54" height="58" rx="2" fill="rgba(255,255,255,0.08)"/>
              <line x1="23" y1="235" x2="77" y2="235" stroke="rgba(200,169,110,0.5)" stroke-width="0.5"/>
              <line x1="23" y1="155" x2="77" y2="155" stroke="rgba(200,169,110,0.5)" stroke-width="0.5"/>
            </svg>
          </div>
          <div class="product-info">
            <div class="stars">${'★'.repeat(p.stars)}${'☆'.repeat(5 - p.stars)}</div>
            <div class="product-region">${p.region}</div>
            <div class="product-name">${p.name}</div>
            <div class="product-grape">${p.grape}</div>
          </div>
        </a>
        <div class="product-info">
          <div class="product-footer">
            <div class="product-price">R$ ${p.price.toFixed(2).replace('.', ',')}</div>
            <button class="add-btn" onclick="addToCart(${p.id})">+ Adicionar</button>
          </div>
        </div>
      </div>`;
  }).join('');
}

function addToCart(id) {
  const p = products.find(x => x.id === id);
  const existing = cart.find(x => x.id === id);
  if (existing) existing.qty++;
  else cart.push({ ...p, qty: 1 });
  updateCart();
  showToast(`${p.name} adicionado!`);
}

function updateCart() {
  saveCart();
  const count = cart.reduce((a, x) => a + x.qty, 0);
  const total = cart.reduce((a, x) => a + x.price * x.qty, 0);

  document.querySelectorAll('.cart-count, #cart-count, #cart-count-header').forEach(el => {
    if (el) el.textContent = count;
  });
  const totalEl = document.getElementById('cart-total');
  if (totalEl) totalEl.textContent = 'R$ ' + total.toFixed(2).replace('.', ',');

  const itemsEl = document.getElementById('cart-items');
  if (!itemsEl) return;

  if (cart.length === 0) {
    itemsEl.innerHTML = '<div class="empty-cart">Seu carrinho está vazio</div>';
  } else {
    itemsEl.innerHTML = cart.map(item => {
      const col = item.type === 'tinto' ? '#3a0810' : '#6a8a3a';
      const cap = item.type === 'tinto' ? '#4a0e1a' : '#8a9a4a';
      return `
        <div class="cart-item">
          <div class="cart-item-img">
            <svg width="24" height="55" viewBox="0 0 100 300" fill="none">
              <rect x="40" y="0" width="20" height="28" rx="3" fill="${cap}"/>
              <path d="M35 28 Q20 55 20 95 L20 265 Q20 285 50 285 Q80 285 80 265 L80 95 Q80 55 65 28 Z" fill="${col}"/>
            </svg>
          </div>
          <div class="cart-item-info">
            <div class="cart-item-name">${item.name}</div>
            <div class="cart-item-price">R$ ${item.price.toFixed(2).replace('.', ',')}</div>
            <div class="cart-item-qty">Qtd: ${item.qty}</div>
          </div>
        </div>`;
    }).join('');
  }
}

function openCart() {
  const sidebar = document.getElementById('cart-sidebar');
  const overlay = document.getElementById('cart-overlay');
  if (sidebar) sidebar.classList.add('open');
  if (overlay) overlay.classList.add('open');
}
function closeCart() {
  const sidebar = document.getElementById('cart-sidebar');
  const overlay = document.getElementById('cart-overlay');
  if (sidebar) sidebar.classList.remove('open');
  if (overlay) overlay.classList.remove('open');
}

function showToast(msg) {
  const t = document.getElementById('toast');
  if (!t) return;
  t.textContent = msg;
  t.classList.add('show');
  setTimeout(() => t.classList.remove('show'), 2500);
}

function handleNewsletter(e) {
  e.preventDefault();
  showToast('Inscrição realizada com sucesso!');
  e.target.reset();
}

// --- Init ---
renderProducts();
updateCart();
