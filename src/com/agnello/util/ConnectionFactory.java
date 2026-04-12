package com.agnello.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * ConnectionFactory — Fábrica de conexões com o banco de dados.
 * 
 * Para o Sprint 2, usamos Oracle Cloud Free Tier (Oracle Autonomous Database).
 * Se preferir testar localmente, pode trocar para H2 ou MySQL.
 * 
 * CONFIGURAÇÃO:
 * 1. Altere a URL, USER e PASSWORD conforme seu banco.
 * 2. Para Oracle Cloud, baixe o Wallet e configure o caminho.
 * 3. Para teste local com H2, descomente a seção H2 abaixo.
 */
public class ConnectionFactory {

    // ============================================
    // OPÇÃO 1: Oracle Cloud (Autonomous Database)
    // ============================================
    // private static final String URL = "jdbc:oracle:thin:@seudb_high?TNS_ADMIN=/caminho/para/wallet";
    // private static final String USER = "ADMIN";
    // private static final String PASSWORD = "SuaSenhaAqui123";
    // private static final String DRIVER = "oracle.jdbc.OracleDriver";
    private static final String URL = "jdbc:oracle:thin:@agnellodb_high?TNS_ADMIN=C:/wallet_agnello";
    private static final String USER = "ADMIN";
    private static final String PASSWORD = "SuaSenhaAqui123"; // SUBSTITUA PELA SENHA DO SEU BANCO
    private static final String DRIVER = "oracle.jdbc.OracleDriver";

    // ============================================
    // OPÇÃO 2: H2 Database (para testes locais — RECOMENDADO PARA COMEÇAR)
    // ============================================
    private static final String URL = "jdbc:h2:~/agnello_db;AUTO_SERVER=TRUE";
    private static final String USER = "sa";
    private static final String PASSWORD = "";
    private static final String DRIVER = "org.h2.Driver";
    // private static final String URL = "jdbc:h2:~/agnello_db;AUTO_SERVER=TRUE";
    // private static final String USER = "sa";
    // private static final String PASSWORD = "";
    // private static final String DRIVER = "org.h2.Driver";

    // ============================================
    // OPÇÃO 3: MySQL Local
    // ============================================
    // private static final String URL = "jdbc:mysql://localhost:3306/vinheria_agnello?useSSL=false&serverTimezone=America/Sao_Paulo";
    // private static final String USER = "root";
    // private static final String PASSWORD = "sua_senha";
    // private static final String DRIVER = "com.mysql.cj.jdbc.Driver";

    /**
     * Retorna uma nova conexão com o banco de dados.
     */
    public static Connection getConnection() throws SQLException {
        try {
            Class.forName(DRIVER);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver JDBC não encontrado: " + DRIVER, e);
        }
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    /**
     * Fecha uma conexão de forma segura.
     */
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
