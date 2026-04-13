package com.agnello.servlet;

import com.agnello.dao.UsuarioDAO;
import com.agnello.model.Usuario;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/CadastroServlet")
public class CadastroServlet extends HttpServlet {

    private UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    public void init() throws ServletException {
        usuarioDAO.criarTabela();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String nome = request.getParameter("nome");
        String sobrenome = request.getParameter("sobrenome");
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");
        String confirmarSenha = request.getParameter("confirmarSenha");
        String dataNascStr = request.getParameter("dataNascimento");

        request.setAttribute("nome", nome);
        request.setAttribute("sobrenome", sobrenome);
        request.setAttribute("email", email);
        request.setAttribute("dataNascimento", dataNascStr);

        if (nome == null || nome.trim().isEmpty() ||
            sobrenome == null || sobrenome.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            senha == null || senha.trim().isEmpty()) {
            request.setAttribute("erro", "Todos os campos são obrigatórios.");
            request.getRequestDispatcher("cadastro.jsp").forward(request, response);
            return;
        }

        if (senha.length() < 6) {
            request.setAttribute("erro", "A senha deve ter pelo menos 6 caracteres.");
            request.getRequestDispatcher("cadastro.jsp").forward(request, response);
            return;
        }

        if (!senha.equals(confirmarSenha)) {
            request.setAttribute("erro", "As senhas não coincidem.");
            request.getRequestDispatcher("cadastro.jsp").forward(request, response);
            return;
        }

        if (usuarioDAO.emailExiste(email.trim())) {
            request.setAttribute("erro", "Este e-mail já está cadastrado.");
            request.getRequestDispatcher("cadastro.jsp").forward(request, response);
            return;
        }

        Usuario usuario = new Usuario();
        usuario.setNome(nome.trim());
        usuario.setSobrenome(sobrenome.trim());
        usuario.setEmail(email.trim());
        usuario.setSenha(senha);

        if (dataNascStr != null && !dataNascStr.isEmpty()) {
            try {
                usuario.setDataNascimento(LocalDate.parse(dataNascStr));
            } catch (Exception e) {
                // data inválida ignorada
            }
        }

        boolean sucesso = usuarioDAO.inserir(usuario);

        if (sucesso) {
            request.setAttribute("sucesso", "Conta criada com sucesso! Faça login.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            request.setAttribute("erro", "Erro ao criar conta. Tente novamente.");
            request.getRequestDispatcher("cadastro.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("cadastro.jsp");
    }
}
