<%-- 
    Document   : ProdutoLista
    Created on : 2 de nov. de 2024, 18:14:01
    Author     : fel-f
--%>

<%@ page import="java.text.DecimalFormat" %>
<%@ page import="cadastroee.model.Produto" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Lista de Produtos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>

<style>
    body {
        background-color:rgb(236, 236, 236)
    }
    h1 {
        margin: 20px
    }
    .card {
        padding: 20px;
    }
</style>
</head>

<body>
    <div class="container">
        <div class="header-section text-center">
            <h1>Listagem de Produtos</h1>
        </div>
        <div class="card">
            <div class="card-body">
                <table class="table table-bordered table-responsive">
                    <tr class="table-dark text-center">
                        <th>ID</th>
                        <th>Nome do Produto</th>
                        <th>Quantidade</th>
                        <th>Preço</th>
                        <th>Ações</th>
                    </tr>
                        <%
                            DecimalFormat df = new DecimalFormat("#,##0.00");
                            List<Produto> produtos = (List<Produto>) request.getAttribute("produtos");
                            if (produtos != null && !produtos.isEmpty()) {
                                for (Produto produto : produtos) {
                        %>
                        <tr>
                            <td class="text-center"><%=produto.getIdProduto()%></td>
                            <td class="text-center"><%=produto.getNome()%></td>
                            <td class="text-center"><%=produto.getQuantidade()%></td>
                            <td class="text-center">R$ <%=df.format(produto.getPrecoVenda())%></td>
                            <td class="text-end">
                                <a class="btn btn-primary btn-sm" href="ServletProdutoFC?acao=formAlterar&id=<%=produto.getIdProduto()%>">Alterar</a>
                                <a class="btn btn-danger btn-sm" href="ServletProdutoFC?acao=excluir&id=<%=produto.getIdProduto()%>">Excluir</a>
                            </td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr>
                            <td>Nenhum produto foi encontrado.</td>
                        </tr>
                        <%
                            }
                        %>
                </table>
                <div class="text-end mb-3">
                    <a class="btn btn-primary" href="ServletProdutoFC?acao=formIncluir">Cadastrar Produto</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>