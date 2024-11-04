/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package cadastroee.servlets;

import cadastroee.model.Produto;
import cadastroee.controller.ProdutoFacadeLocal;
import java.io.IOException;
import java.util.List;
import jakarta.ejb.EJB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author fel-f
 */

@WebServlet(name= "ServletProdutoFC", urlPatterns= {"/ServletProdutoFC"})
public class ServletProdutoFC extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    @EJB
	private ProdutoFacadeLocal facade;
	
	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String acao = request.getParameter("acao");
        String destino = "";

        switch (acao) {
            case "formIncluir" -> destino = "ProdutoDados.jsp";

            case "excluir" -> {
                int idDel = Integer.parseInt(request.getParameter("id"));
                facade.remove(facade.find(idDel));
                List<Produto> delProdutos = facade.findAll();
                request.setAttribute("produtos", delProdutos);
                destino = "ProdutoLista.jsp";
            }

            case "formAlterar" -> {
                int id = Integer.parseInt(request.getParameter("id"));
                Produto produto = facade.find(id);
                request.setAttribute("produto", produto);
                destino = "ProdutoDados.jsp";
            }

            default -> {
                List<Produto> produtos = facade.findAll();
                request.setAttribute("produtos", produtos);
                destino = "ProdutoLista.jsp";
            }
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher(destino);
        dispatcher.forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String acao = request.getParameter("acao");
        acao = acao == null || acao.isEmpty() ? " " : acao;

        String destino = "ProdutoLista.jsp";

        switch (acao) {

            case "incluir" -> {
                String nome = request.getParameter("nome");
                int quantidade = Integer.parseInt(request.getParameter("quantidade"));
                Float precoVenda = Float.valueOf(request.getParameter("precoVenda"));

                Produto newProduto = new Produto();
                newProduto.setNome(nome);
                newProduto.setQuantidade(quantidade);
                newProduto.setPrecoVenda(precoVenda);

                facade.create(newProduto);

                List<Produto> newProdutos = facade.findAll();
                request.setAttribute("produtos", newProdutos);
            }

            case "alterar" -> {
                Produto alterarProduto = facade.find(Integer.valueOf(request.getParameter("id")));

                String alterarNome = request.getParameter("nome");
                int alterarQuantidade = Integer.parseInt(request.getParameter("quantidade"));
                Float alterarPrecoVenda = Float.valueOf(request.getParameter("precoVenda"));

                alterarProduto.setNome(alterarNome);
                alterarProduto.setQuantidade(alterarQuantidade);
                alterarProduto.setPrecoVenda(alterarPrecoVenda);

                facade.edit(alterarProduto);
                List<Produto> alterarProdutos = facade.findAll();
                request.setAttribute("produtos", alterarProdutos);
            }

            default -> {
                List<Produto> produtos = facade.findAll();
                request.setAttribute("produtos", produtos);
            }
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher(destino);
        dispatcher.forward(request, response);
    }
}
