package com.agnello.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionFactory {

    // Em produção (Railway), usa variáveis de ambiente se definidas.
    // Localmente, cai no H2 em arquivo com modo Oracle.
    private static final String URL = System.getenv("DB_URL") != null
            ? System.getenv("DB_URL")
            : System.getProperty("app.env", "dev").equals("prod")
                    ? "jdbc:h2:mem:agnellodb;MODE=Oracle;DB_CLOSE_DELAY=-1;DB_CLOSE_ON_EXIT=FALSE"
                    : "jdbc:h2:~/agnello_db;AUTO_SERVER=TRUE;MODE=Oracle";

    private static final String USER = System.getenv("DB_USER") != null
            ? System.getenv("DB_USER")
            : "sa";

    private static final String PASSWORD = System.getenv("DB_PASSWORD") != null
            ? System.getenv("DB_PASSWORD")
            : "";

    private static final String DRIVER = "org.h2.Driver";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName(DRIVER);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver JDBC não encontrado: " + DRIVER, e);
        }
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

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
