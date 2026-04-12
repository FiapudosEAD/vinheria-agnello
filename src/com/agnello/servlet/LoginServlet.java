package com.agnello.servlet;

import com.agnello.dao.UsuarioDAO;
import com.agnello.model.Usuario;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

/**
 * LoginServlet — Processa o formulário de login.
 * 
 * Fluxo:
 * 1. Recebe email e senha do formulário (POST)
 * 2. Busca no banco via UsuarioDAO
 * 3. Se encontrou → cria sessão e redireciona para index.jsp
 * 4. Se não encontrou → volta para login.jsp com mensagem de erro
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    public void init() throws ServletException {
        // Garante que a tabela existe ao iniciar o servlet
        usuarioDAO.criarTabela();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String senha = request.getParameter("senha");

        // Validação básica
        if (email == null || email.trim().isEmpty() ||
            senha == null || senha.trim().isEmpty()) {
            request.setAttribute("erro", "Preencha todos os campos.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Busca o usuário no banco
        Usuario usuario = usuarioDAO.buscarPorEmailSenha(email.trim(), senha);

        if (usuario != null) {
            // Login OK — cria sessão
            HttpSession session = request.getSession();
            session.setAttribute("usuarioLogado", usuario);
            session.setMaxInactiveInterval(30 * 60); // 30 minutos

            response.sendRedirect("index.jsp");
        } else {
            // Login falhou
            request.setAttribute("erro", "E-mail ou senha inválidos.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Se acessar via GET, redireciona para a página de login
        response.sendRedirect("login.jsp");
    }
}
