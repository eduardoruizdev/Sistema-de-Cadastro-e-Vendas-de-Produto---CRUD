<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Gerenciadoestoq.aspx.cs" Inherits="CODIGOLOJAS.Pages.Gerenciadoestoq" %>

<!DOCTYPE html>
<html lang="pt-br">
<head runat="server">
    <meta charset="utf-8" />
    <title>Gerenciador Pro | CODIGO LOJAS</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" />
    <link href="../style/StyleEstoque.css" rel="stylesheet" />

    <script>
        function abrirModal(id) { document.getElementById(id).style.display = "flex"; }
        function fecharModal(id) { document.getElementById(id).style.display = "none"; }

        function filtrarProdutos() {
            let termo = document.getElementById('txtBusca').value.toLowerCase();
            let cards = document.querySelectorAll('.produto-card');
            cards.forEach(card => {
                let nome = card.querySelector('h3').innerText.toLowerCase();
                let cod = card.querySelector('.id-ref').innerText.toLowerCase();
                card.style.display = (nome.includes(termo) || cod.includes(termo)) ? "flex" : "none";
            });
        }
    </script>
</head>
<body>
<form id="form1" runat="server">
    <nav class="sidebar">
        <div>
            <h2 class="brand">ADMIN LOJA</h2>
            <a href="#" class="menu-item active">
                <span class="material-icons-round">inventory_2</span> Estoque
            </a>
            <a href="/Pages/categorias.aspx" class="menu-item">
                <span class="material-icons-round">category</span> Categorias
            </a>
        </div>

        <a href="/Pages/index.aspx" class="menu-item logout">
            <span class="material-icons-round">logout</span> Sair e Voltar
        </a>
    </nav>

    <main class="main-content">
        <div class="header-actions">
            <div>
                <h1>Gestão de Produtos</h1>
                <p>Controle de inventário e precificação inteligente</p>
            </div>
            <button type="button" class="btn-add" onclick="abrirModal('modalCadastro')">
                <span class="material-icons-round">add</span> Novo Item
            </button>
        </div>

        <div class="search-bar">
            <span class="material-icons-round">search</span>
            <input type="text" id="txtBusca" onkeyup="filtrarProdutos()" placeholder="Buscar por nome ou código..." />
        </div>

        <!-- GRID DE 3 COLUNAS -->
        <div class="lista-produtos">
            <asp:Repeater ID="rptProdutos" runat="server">
                <ItemTemplate>
                    <div class="produto-card">
                        <div class="img-container">
                            <img src='<%# Eval("Imagem") %>' onerror="this.src='https://via.placeholder.com/400x300?text=Produto'" />
                            <span class="categoria-badge">Cat: <%# Eval("IdCategoria") %></span>
                        </div>
                        <div class="card-body">
                            <span class="id-ref">Cód: #<%# Eval("Codigo") %></span>
                            <h3><%# Eval("Nome") %></h3>
                            <div class="preco-tag">R$ <%# Eval("Valor", "{0:N2}") %></div>
                            <div class="acoes-produto">
                                <asp:LinkButton runat="server" CssClass="btn-action edit" CommandArgument='<%# Eval("Id") %>' OnCommand="EditarProduto_Click">
                                    <span class="material-icons-round">edit</span>
                                </asp:LinkButton>
                                <asp:LinkButton runat="server" CssClass="btn-action delete" CommandArgument='<%# Eval("Id") %>' OnCommand="ExcluirProduto_Click" OnClientClick="return confirm('Excluir este produto?');">
                                    <span class="material-icons-round">delete</span>
                                </asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </main>

    <!-- MODAL -->
    <div class="modal" id="modalCadastro">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Dados do Produto</h2>
                <button type="button" class="close-btn" onclick="fecharModal('modalCadastro')">&times;</button>
            </div>

            <asp:HiddenField ID="hfIdProduto" runat="server" />
            <asp:HiddenField ID="hfImagemAtual" runat="server" />

            <div class="form-row">
                <div class="form-group">
                    <label>Código</label>
                    <asp:TextBox ID="txtCodigo" runat="server" />
                </div>
                <div class="form-group">
                    <label>Preço</label>
                    <asp:TextBox ID="txtPreco" runat="server" placeholder="Ex: 3.600 ou 3,50" />
                </div>
            </div>

            <div class="form-group">
                <label>Nome do Produto</label>
                <asp:TextBox ID="txtNome" runat="server" />
            </div>

            <div class="form-group">
                <label>Categoria</label>
                <asp:DropDownList ID="ddlCategoria" runat="server" />
            </div>

            <div class="form-group">
                <label>Descrição</label>
                <asp:TextBox ID="txtDescricao" runat="server" TextMode="MultiLine" Rows="3" />
            </div>

            <div class="form-group">
                <label>Imagem</label>
                <asp:FileUpload ID="fileUploadImagem" runat="server" />
            </div>

            <div class="modal-footer">
                <button type="button" class="btn-cancel" onclick="fecharModal('modalCadastro')">Cancelar</button>
                <asp:Button ID="btnSalvar" runat="server" Text="Salvar Alterações" CssClass="btn-save" OnClick="btnSalvar_Click" />
            </div>
        </div>
    </div>
</form>
</body>
</html>