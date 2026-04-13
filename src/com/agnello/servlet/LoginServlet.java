package com.agnello.servlet;

import com.agnello.dao.UsuarioDAO;
import com.agnello.model.Usuario;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    public void init() throws ServletException {
        usuarioDAO.criarTabela();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String senha = request.getParameter("senha");

        if (email == null || email.trim().isEmpty() ||
            senha == null || senha.trim().isEmpty()) {
            request.setAttribute("erro", "Preencha todos os campos.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        Usuario usuario = usuarioDAO.buscarPorEmailSenha(email.trim(), senha);

        if (usuario != null) {
            HttpSession session = request.getSession();
            session.setAttribute("usuarioLogado", usuario);
            session.setMaxInactiveInterval(30 * 60);
            response.sendRedirect("index.jsp");
        } else {
            request.setAttribute("erro", "E-mail ou senha inválidos.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }
}
