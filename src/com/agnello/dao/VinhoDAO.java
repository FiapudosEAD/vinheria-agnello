package com.agnello.dao;

import com.agnello.model.Vinho;
import com.agnello.util.ConnectionFactory;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VinhoDAO {

    public void inicializarTabela() {
        String createSql = "CREATE TABLE IF NOT EXISTS VINHOS ("
                + "id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, "
                + "nome VARCHAR2(200) NOT NULL, "
                + "uva VARCHAR2(150) NOT NULL, "
                + "regiao VARCHAR2(200) NOT NULL, "
                + "tipo VARCHAR2(50) NOT NULL, "
                + "preco DECIMAL(10,2) NOT NULL, "
                + "descricao CLOB, "
                + "teor_alcoolico VARCHAR2(20), "
                + "safra VARCHAR2(10), "
                + "envelhecimento VARCHAR2(50), "
                + "temp_servico VARCHAR2(20), "
                + "harmonizacao CLOB, "
                + "avaliacao NUMBER DEFAULT 5, "
                + "badge VARCHAR2(50), "
                + "ativo NUMBER(1) DEFAULT 1"
                + ")";

        try (Connection conn = ConnectionFactory.getConnection();
             Statement stmt = conn.createStatement()) {
            stmt.execute(createSql);
            inserirVinhosIniciais(conn);
        } catch (SQLException e) {
            System.out.println("Aviso: Tabela VINHOS já existe ou erro: " + e.getMessage());
        }
    }

    private void inserirVinhosIniciais(Connection conn) throws SQLException {
        String countSql = "SELECT COUNT(*) FROM VINHOS";
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(countSql)) {
            if (rs.next() && rs.getInt(1) > 0) return;
        }

        String sql = "INSERT INTO VINHOS (nome, uva, regiao, tipo, preco, descricao, teor_alcoolico, safra, envelhecimento, temp_servico, harmonizacao, avaliacao, badge) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        Object[][] vinhos = {
            {"Cabernet Sauvignon Reserva", "Cabernet Sauvignon", "Serra Gaúcha, RS", "tinto", 189.00,
             "Um Cabernet de altitude com corpo robusto e taninos elegantes. Notas de cassis, amora e baunilha.",
             "13,5%", "2019", "18 meses", "16–18°C", "Filé mignon ao molho madeira, cordeiro assado, queijos curados.", 5, "Mais Vendido"},
            {"Merlot Gran Seleção", "Merlot", "Vale dos Vinhedos, RS", "tinto", 149.00,
             "Merlot de corpo médio, aveludado e frutado. Aromas de ameixa madura e cereja.",
             "13%", "2021", "10 meses", "16–18°C", "Massas com molho de tomate, pizzas artesanais, carnes brancas grelhadas.", 4, null},
            {"Chardonnay Signature", "Chardonnay", "Farroupilha, RS", "branco", 129.00,
             "Chardonnay de altitude com mineralidade marcante e frescor vibrante.",
             "12,5%", "2023", "6 meses", "8–10°C", "Frutos do mar, salmão grelhado, risotos cremosos.", 5, "Novo"},
            {"Pinot Noir Altitude", "Pinot Noir", "São Joaquim, SC", "tinto", 219.00,
             "Pinot Noir excepcional cultivado a 1.400m de altitude. Elegante e sedoso.",
             "12,8%", "2020", "14 meses", "14–16°C", "Pato confitado, cogumelos salteados, queijo brie.", 5, "Premiado"},
            {"Sauvignon Blanc Estate", "Sauvignon Blanc", "Serra Gaúcha, RS", "branco", 115.00,
             "Sauvignon Blanc refrescante e aromático. Notas cítricas de limão e maracujá.",
             "12%", "2023", "Inox", "6–8°C", "Ceviche, ostras, saladas frescas e sushi.", 4, null},
            {"Espumante Brut Natura", "Chardonnay / Pinot Noir", "Garibaldi, RS", "espumante", 135.00,
             "Espumante Brut elaborado pelo método Champenoise com 24 meses sobre borras.",
             "12%", "2021", "24 meses", "4–6°C", "Canapés, frutos do mar, pratos leves.", 5, "Favorito"},
            {"Tannat Barrique", "Tannat", "Candiota, RS", "tinto", 175.00,
             "Tannat encorpado e potente, com taninos firmes e cor violácea intensa.",
             "14%", "2020", "12 meses", "16–18°C", "Costela no bafo, churrasco, feijoada e queijos azuis.", 4, null},
            {"Moscatel Rosé", "Moscato Rosa", "Serra Gaúcha, RS", "espumante", 99.00,
             "Moscatel rosado doce e aromático. Fragrância de rosas, lichia e uva fresca.",
             "7,5%", "2023", "Charmat", "4–6°C", "Sobremesas com frutas vermelhas, bolos e tortas.", 4, null},
            {"Rosé Provence Style", "Merlot / Cabernet", "Serra Gaúcha, RS", "rose", 109.00,
             "Rosé de cor salmão pálido inspirado nos vinhos da Provence.",
             "11,5%", "2023", "Inox", "8–10°C", "Saladas mediterrâneas, frutos do mar, bruschettas.", 4, "Novo"},
            {"Gewürztraminer Colheita Tardia", "Gewürztraminer", "Pinto Bandeira, RS", "branco", 165.00,
             "Colheita tardia com concentração aromática extraordinária. Notas de lichia, mel e gengibre.",
             "13%", "2022", "8 meses", "8–10°C", "Foie gras, queijos azuis, comida tailandesa.", 5, "Raro"}
        };

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            for (Object[] v : vinhos) {
                ps.setString(1, (String) v[0]);
                ps.setString(2, (String) v[1]);
                ps.setString(3, (String) v[2]);
                ps.setString(4, (String) v[3]);
                ps.setDouble(5, (Double) v[4]);
                ps.setString(6, (String) v[5]);
                ps.setString(7, (String) v[6]);
                ps.setString(8, (String) v[7]);
                ps.setString(9, (String) v[8]);
                ps.setString(10, (String) v[9]);
                ps.setString(11, (String) v[10]);
                ps.setInt(12, (Integer) v[11]);
                if (v[12] != null) ps.setString(13, (String) v[12]);
                else ps.setNull(13, Types.VARCHAR);
                ps.executeUpdate();
            }
        }
    }

    public List<Vinho> listarTodos() {
        List<Vinho> vinhos = new ArrayList<>();
        String sql = "SELECT * FROM VINHOS WHERE ativo = 1 ORDER BY id ASC";

        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                vinhos.add(mapearVinho(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vinhos;
    }

    public List<Vinho> buscarPorTipo(String tipo) {
        List<Vinho> vinhos = new ArrayList<>();
        String sql = "SELECT * FROM VINHOS WHERE ativo = 1 AND tipo = ? ORDER BY preco ASC";

        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, tipo);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    vinhos.add(mapearVinho(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vinhos;
    }

    public Vinho buscarPorId(int id) {
        String sql = "SELECT * FROM VINHOS WHERE id = ? AND ativo = 1";

        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapearVinho(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private Vinho mapearVinho(ResultSet rs) throws SQLException {
        Vinho v = new Vinho();
        v.setId(rs.getInt("id"));
        v.setNome(rs.getString("nome"));
        v.setUva(rs.getString("uva"));
        v.setRegiao(rs.getString("regiao"));
        v.setTipo(rs.getString("tipo"));
        v.setPreco(rs.getDouble("preco"));
        v.setDescricao(rs.getString("descricao"));
        v.setTeorAlcoolico(rs.getString("teor_alcoolico"));
        v.setSafra(rs.getString("safra"));
        v.setEnvelhecimento(rs.getString("envelhecimento"));
        v.setTempServico(rs.getString("temp_servico"));
        v.setHarmonizacao(rs.getString("harmonizacao"));
        v.setAvaliacao(rs.getInt("avaliacao"));
        v.setBadge(rs.getString("badge"));
        v.setAtivo(rs.getInt("ativo") == 1);
        return v;
    }
}
