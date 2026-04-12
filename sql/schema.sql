-- ============================================
-- VINHERIA AGNELLO — Script de Criação do Banco
-- Sprint 2 — Banco de Dados
-- ============================================
-- 
-- Este script cria as tabelas necessárias para o projeto.
-- Compatível com: H2, MySQL, Oracle (com pequenos ajustes).
-- 
-- Para H2 (teste local): Execute automaticamente via UsuarioDAO.criarTabela()
-- Para Oracle Cloud: Execute no SQL Developer ou via SQL Worksheet
-- Para MySQL: Execute no MySQL Workbench ou terminal

-- ============================================
-- TABELA: USUARIOS
-- Armazena os dados dos clientes registrados
-- ============================================
CREATE TABLE IF NOT EXISTS USUARIOS (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    nome            VARCHAR(100)    NOT NULL,
    sobrenome       VARCHAR(100)    NOT NULL,
    email           VARCHAR(200)    NOT NULL UNIQUE,
    senha           VARCHAR(255)    NOT NULL,
    data_nascimento DATE,
    data_cadastro   TIMESTAMP       DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- TABELA: VINHOS
-- Catálogo de vinhos disponíveis na loja
-- ============================================
CREATE TABLE IF NOT EXISTS VINHOS (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    nome            VARCHAR(200)    NOT NULL,
    uva             VARCHAR(150)    NOT NULL,
    regiao          VARCHAR(200)    NOT NULL,
    tipo            VARCHAR(50)     NOT NULL,  -- tinto, branco, espumante, rose
    preco           DECIMAL(10,2)   NOT NULL,
    descricao       TEXT,
    teor_alcoolico  VARCHAR(20),
    safra           VARCHAR(10),
    envelhecimento  VARCHAR(50),
    temp_servico    VARCHAR(20),
    harmonizacao    TEXT,
    avaliacao       INT             DEFAULT 5,
    badge           VARCHAR(50),
    ativo           BOOLEAN         DEFAULT TRUE
);

-- ============================================
-- TABELA: PEDIDOS
-- Registra os pedidos realizados pelos clientes
-- ============================================
CREATE TABLE IF NOT EXISTS PEDIDOS (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id      INT             NOT NULL,
    data_pedido     TIMESTAMP       DEFAULT CURRENT_TIMESTAMP,
    valor_total     DECIMAL(10,2)   NOT NULL,
    status          VARCHAR(50)     DEFAULT 'PENDENTE',
    FOREIGN KEY (usuario_id) REFERENCES USUARIOS(id)
);

-- ============================================
-- TABELA: ITENS_PEDIDO
-- Detalha os itens de cada pedido
-- ============================================
CREATE TABLE IF NOT EXISTS ITENS_PEDIDO (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id       INT             NOT NULL,
    vinho_id        INT             NOT NULL,
    quantidade      INT             NOT NULL,
    preco_unitario  DECIMAL(10,2)   NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES PEDIDOS(id),
    FOREIGN KEY (vinho_id)  REFERENCES VINHOS(id)
);

-- ============================================
-- DADOS INICIAIS: Inserção dos vinhos do catálogo
-- ============================================
INSERT INTO VINHOS (nome, uva, regiao, tipo, preco, descricao, teor_alcoolico, safra, envelhecimento, temp_servico, harmonizacao, avaliacao, badge) VALUES
('Cabernet Sauvignon Reserva', 'Cabernet Sauvignon', 'Serra Gaúcha, RS', 'tinto', 189.00,
 'Um Cabernet de altitude com corpo robusto e taninos elegantes. Notas de cassis, amora e baunilha.', 
 '13,5%', '2019', '18 meses', '16–18°C', 
 'Filé mignon ao molho madeira, cordeiro assado, queijos curados.', 5, 'Mais Vendido'),

('Merlot Gran Seleção', 'Merlot', 'Vale dos Vinhedos, RS', 'tinto', 149.00,
 'Merlot de corpo médio, aveludado e frutado. Aromas de ameixa madura e cereja.',
 '13%', '2021', '10 meses', '16–18°C',
 'Massas com molho de tomate, pizzas artesanais, carnes brancas grelhadas.', 4, NULL),

('Chardonnay Signature', 'Chardonnay', 'Farroupilha, RS', 'branco', 129.00,
 'Chardonnay de altitude com mineralidade marcante e frescor vibrante.',
 '12,5%', '2023', '6 meses', '8–10°C',
 'Frutos do mar, salmão grelhado, risotos cremosos.', 5, 'Novo'),

('Pinot Noir Altitude', 'Pinot Noir', 'São Joaquim, SC', 'tinto', 219.00,
 'Pinot Noir excepcional cultivado a 1.400m de altitude. Elegante e sedoso.',
 '12,8%', '2020', '14 meses', '14–16°C',
 'Pato confitado, cogumelos salteados, queijo brie.', 5, 'Premiado'),

('Sauvignon Blanc Estate', 'Sauvignon Blanc', 'Serra Gaúcha, RS', 'branco', 115.00,
 'Sauvignon Blanc refrescante e aromático. Notas cítricas de limão e maracujá.',
 '12%', '2023', 'Inox', '6–8°C',
 'Ceviche, ostras, saladas frescas e sushi.', 4, NULL),

('Espumante Brut Natura', 'Chardonnay / Pinot Noir', 'Garibaldi, RS', 'espumante', 135.00,
 'Espumante Brut elaborado pelo método Champenoise com 24 meses sobre borras.',
 '12%', '2021', '24 meses', '4–6°C',
 'Canapés, frutos do mar, pratos leves.', 5, 'Favorito'),

('Tannat Barrique', 'Tannat', 'Candiota, RS', 'tinto', 175.00,
 'Tannat encorpado e potente, com taninos firmes e cor violácea intensa.',
 '14%', '2020', '12 meses', '16–18°C',
 'Costela no bafo, churrasco, feijoada e queijos azuis.', 4, NULL),

('Moscatel Rosé', 'Moscato Rosa', 'Serra Gaúcha, RS', 'espumante', 99.00,
 'Moscatel rosado doce e aromático. Fragrância de rosas, lichia e uva fresca.',
 '7,5%', '2023', 'Charmat', '4–6°C',
 'Sobremesas com frutas vermelhas, bolos e tortas.', 4, NULL),

('Rosé Provence Style', 'Merlot / Cabernet', 'Serra Gaúcha, RS', 'rose', 109.00,
 'Rosé de cor salmão pálido inspirado nos vinhos da Provence.',
 '11,5%', '2023', 'Inox', '8–10°C',
 'Saladas mediterrâneas, frutos do mar, bruschettas.', 4, 'Novo'),

('Gewürztraminer Colheita Tardia', 'Gewürztraminer', 'Pinto Bandeira, RS', 'branco', 165.00,
 'Colheita tardia com concentração aromática extraordinária. Notas de lichia, mel e gengibre.',
 '13%', '2022', '8 meses', '8–10°C',
 'Foie gras, queijos azuis, comida tailandesa.', 5, 'Raro');

-- ============================================
-- VERSÃO ORACLE CLOUD (caso precise)
-- Troque AUTO_INCREMENT por GENERATED ALWAYS AS IDENTITY
-- e IF NOT EXISTS não funciona — remova-o.
-- ============================================
-- Exemplo Oracle:
-- CREATE TABLE USUARIOS (
--     id              NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
--     nome            VARCHAR2(100) NOT NULL,
--     ...
-- );
