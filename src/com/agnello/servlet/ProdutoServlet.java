package com.agnello.servlet;

import com.agnello.dao.VinhoDAO;
import com.agnello.model.Vinho;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/ProdutoServlet")
public class ProdutoServlet extends HttpServlet {

    private VinhoDAO vinhoDAO = new VinhoDAO();

    @Override
    public void init() throws ServletException {
        vinhoDAO.inicializarTabela();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");

        if (idStr != null && !idStr.isEmpty()) {
            try {
                int id = Integer.parseInt(idStr);
                Vinho vinho = vinhoDAO.buscarPorId(id);

                if (vinho != null) {
                    request.setAttribute("vinho", vinho);
                    request.getRequestDispatcher("produto.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                // id inválido, redireciona para catálogo
            }
        }

        response.sendRedirect("CatalogoServlet");
    }
}
