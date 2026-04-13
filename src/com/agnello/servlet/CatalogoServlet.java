package com.agnello.servlet;

import com.agnello.dao.VinhoDAO;
import com.agnello.model.Vinho;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/CatalogoServlet")
public class CatalogoServlet extends HttpServlet {

    private VinhoDAO vinhoDAO = new VinhoDAO();

    @Override
    public void init() throws ServletException {
        vinhoDAO.inicializarTabela();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String tipo = request.getParameter("tipo");
        List<Vinho> vinhos;

        if (tipo != null && !tipo.isEmpty() && !tipo.equals("todos")) {
            vinhos = vinhoDAO.buscarPorTipo(tipo);
        } else {
            vinhos = vinhoDAO.listarTodos();
        }

        request.setAttribute("vinhos", vinhos);
        request.getRequestDispatcher("catalogo.jsp").forward(request, response);
    }
}
