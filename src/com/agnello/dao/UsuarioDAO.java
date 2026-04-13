package com.agnello.dao;

import com.agnello.model.Usuario;
import com.agnello.util.ConnectionFactory;
import java.sql.*;

public class UsuarioDAO {

    public void criarTabela() {
        String sql = "CREATE TABLE IF NOT EXISTS USUARIOS ("
                + "id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, "
                + "nome VARCHAR2(100) NOT NULL, "
                + "sobrenome VARCHAR2(100) NOT NULL, "
                + "email VARCHAR2(200) NOT NULL UNIQUE, "
                + "senha VARCHAR2(255) NOT NULL, "
                + "data_nascimento DATE, "
                + "data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP"
                + ")";

        try (Connection conn = ConnectionFactory.getConnection();
             Statement stmt = conn.createStatement()) {
            stmt.execute(sql);
        } catch (SQLException e) {
            System.err.println("Erro ao criar tabela USUARIOS: " + e.getMessage());
        }
    }

    public boolean inserir(Usuario usuario) {
        String sql = "INSERT INTO USUARIOS (nome, sobrenome, email, senha, data_nascimento) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, usuario.getNome());
            ps.setString(2, usuario.getSobrenome());
            ps.setString(3, usuario.getEmail());
            ps.setString(4, usuario.getSenha());

            if (usuario.getDataNascimento() != null) {
                ps.setDate(5, Date.valueOf(usuario.getDataNascimento()));
            } else {
                ps.setNull(5, Types.DATE);
            }

            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Usuario buscarPorEmailSenha(String email, String senha) {
        String sql = "SELECT * FROM USUARIOS WHERE email = ? AND senha = ?";

        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, senha);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Usuario u = new Usuario();
                    u.setId(rs.getInt("id"));
                    u.setNome(rs.getString("nome"));
                    u.setSobrenome(rs.getString("sobrenome"));
                    u.setEmail(rs.getString("email"));
                    u.setSenha(rs.getString("senha"));

                    Date dbDate = rs.getDate("data_nascimento");
                    if (dbDate != null) {
                        u.setDataNascimento(dbDate.toLocalDate());
                    }
                    return u;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean emailExiste(String email) {
        String sql = "SELECT COUNT(*) FROM USUARIOS WHERE email = ?";

        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
