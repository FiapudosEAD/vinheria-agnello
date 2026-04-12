package com.agnello.dao;

import com.agnello.model.Usuario;
import com.agnello.util.ConnectionFactory;

import java.sql.*;
import java.time.LocalDate;

/**
 * UsuarioDAO — Responsável pelas operações de banco de dados
 * relacionadas aos usuários (CRUD).
 */
public class UsuarioDAO {

    /**
     * Cria a tabela USUARIOS caso ela não exista.
     * Chamado automaticamente na primeira execução.
     */
    public void criarTabela() {
        String sql = "CREATE TABLE IF NOT EXISTS USUARIOS ("
                + "id INT AUTO_INCREMENT PRIMARY KEY, "
                + "nome VARCHAR(100) NOT NULL, "
                + "sobrenome VARCHAR(100) NOT NULL, "
                + "email VARCHAR(200) NOT NULL UNIQUE, "
                + "senha VARCHAR(255) NOT NULL, "
                + "data_nascimento DATE"
                + ")";

        try (Connection conn = ConnectionFactory.getConnection();
             Statement stmt = conn.createStatement()) {
            stmt.execute(sql);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Insere um novo usuário no banco de dados.
     * @param usuario Objeto Usuario com os dados a serem inseridos.
     * @return true se inseriu com sucesso, false se houve erro.
     */
    public boolean inserir(Usuario usuario) {
        String sql = "INSERT INTO USUARIOS (nome, sobrenome, email, senha, data_nascimento) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, usuario.getNome());
            ps.setString(2, usuario.getSobrenome());
            ps.setString(3, usuario.getEmail());
            ps.setString(4, usuario.getSenha());
            ps.setDate(5, usuario.getDataNascimento() != null
                    ? Date.valueOf(usuario.getDataNascimento())
                    : null);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            // Email duplicado ou outro erro
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Busca um usuário pelo email e senha (login).
     * @param email E-mail do usuário.
     * @param senha Senha do usuário.
     * @return Objeto Usuario se encontrado, null caso contrário.
     */
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

    /**
     * Verifica se já existe um usuário com o email informado.
     * @param email E-mail a verificar.
     * @return true se o email já está cadastrado.
     */
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
