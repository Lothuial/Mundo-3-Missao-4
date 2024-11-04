<%-- 
    Document   : ProdutoDados
    Created on : 2 de nov. de 2024, 18:14:39
    Author     : fel-f
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="cadastroee.model.Produto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Cadastro de Produtos</title>
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
    <%
        DecimalFormat df = new DecimalFormat("#,##0.00");
        Produto produto = (Produto) request.getAttribute("produto");
        String acao = produto != null ? "alterar" : "incluir";
    %>
    <div>
        <div>
            <h1 class="header-section text-center"><%=acao == "alterar" ? "Alteração" : "Cadastro"%> de Produtos</h1>
        </div>
        <div class="row">
            <div class="col-md-6 offset-md-3">
                <div>
                    <a  class="btn btn-secondary mb-3" href="ServletProdutoFC?acao=listar">Voltar</a>
                </div>
                <div class="card">
                    <div class="card-body">
                        <form class="form-container" action="ServletProdutoFC" method="post">
                            <input type="hidden" name="acao" value="<%=acao%>">
                            <% if (produto != null) { %>
                            <input type="hidden" name="id" value="<%=produto.getIdProduto()%>">
                            <% } %>
                            <div class="mb-3">
                                <label class="form-label" for="nome">Nome</label>
                                <input class="form-control" type="text" name="nome" value="<%=produto != null ? produto.getNome() : ""%>" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label" for="quantidade">Quantidade</label>
                                <input class="form-control" type="text" name="quantidade" value="<%=produto != null ? produto.getQuantidade() : ""%>" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label" for="precoVenda">Preço de Venda</label>
                                <input class="form-control" type="text" name="precoVenda" value="<%=produto != null ? produto.getPrecoVenda() : ""%>" required>
                            </div>
                            <div class="mb-3">
                                <input class="btn btn-primary" type="submit" value="<%=acao == "incluir" ? "Cadastrar" : "Alterar"%> Produto">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>            
</body>
</html>