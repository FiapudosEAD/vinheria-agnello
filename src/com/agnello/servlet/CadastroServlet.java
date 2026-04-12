package com.agnello.servlet;

import com.agnello.dao.UsuarioDAO;
import com.agnello.model.Usuario;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.time.LocalDate;

/**
 * CadastroServlet — Processa o formulário de cadastro de novos usuários.
 * 
 * Fluxo:
 * 1. Recebe dados do formulário (POST)
 * 2. Valida os campos
 * 3. Verifica se email já existe
 * 4. Se OK → insere no banco e redireciona para login.jsp com sucesso
 * 5. Se erro → volta para cadastro.jsp com mensagem de erro
 */
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

        // Coleta os dados do formulário
        String nome = request.getParameter("nome");
        String sobrenome = request.getParameter("sobrenome");
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");
        String confirmarSenha = request.getParameter("confirmarSenha");
        String dataNascStr = request.getParameter("dataNascimento");

        // Validação dos campos obrigatórios
        if (nome == null || nome.trim().isEmpty() ||
            sobrenome == null || sobrenome.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            senha == null || senha.trim().isEmpty()) {
            request.setAttribute("erro", "Todos os campos são obrigatórios.");
            request.getRequestDispatcher("cadastro.jsp").forward(request, response);
            return;
        }

        // Validação de senha
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

        // Verifica se o email já existe
        if (usuarioDAO.emailExiste(email.trim())) {
            request.setAttribute("erro", "Este e-mail já está cadastrado.");
            request.getRequestDispatcher("cadastro.jsp").forward(request, response);
            return;
        }

        // Cria o objeto Usuario
        Usuario usuario = new Usuario();
        usuario.setNome(nome.trim());
        usuario.setSobrenome(sobrenome.trim());
        usuario.setEmail(email.trim());
        usuario.setSenha(senha); // Em produção, usar hash (BCrypt)

        // Parse da data de nascimento
        if (dataNascStr != null && !dataNascStr.isEmpty()) {
            try {
                usuario.setDataNascimento(LocalDate.parse(dataNascStr));
            } catch (Exception e) {
                // Ignora data inválida
            }
        }

        // Insere no banco de dados
        boolean sucesso = usuarioDAO.inserir(usuario);

        if (sucesso) {
            // Redireciona para login com mensagem de sucesso
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
