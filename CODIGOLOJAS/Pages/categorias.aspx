<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="categorias.aspx.cs" Inherits="CODIGOLOJAS.Pages.categorias" %>

<!DOCTYPE html>
<html lang="pt-br">
<head runat="server">
    <meta charset="utf-8" />
    <title>Categorias | Gerenciador Administrativo</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons+Round">
    <link href="../style/StyleCategoria.css" rel="stylesheet" />

    <script>
        function abrirModal() { document.getElementById('modalCategoria').style.display = "flex"; }
        function fecharModal() { document.getElementById('modalCategoria').style.display = "none"; }

        function filtrarCategorias() {
            let termo = document.getElementById('txtBusca').value.toLowerCase();
            let linhas = document.querySelectorAll('tbody tr');
            linhas.forEach(linha => {
                let nome = linha.cells[1].innerText.toLowerCase();
                linha.style.display = nome.includes(termo) ? "" : "none";
            });
        }
    </script>
</head>

<body>
    <form id="form1" runat="server">

        <nav class="sidebar">
            <div>
                <h2 class="brand">LOJA ADMIN</h2>
                <a href="/Pages/Gerenciadoestoq.aspx" class="menu-item">
                    <span class="material-icons-round">inventory_2</span> Estoque
                </a>
                <a href="categorias.aspx" class="menu-item active">
                    <span class="material-icons-round">category</span> Categorias
                </a>
            </div>

            <!-- BOTÃO SAIR ADICIONADO -->
            <a href="/Pages/index.aspx" class="menu-item logout">
                <span class="material-icons-round">logout</span> Sair e Voltar
            </a>
        </nav>

        <main class="main-content">
            <div class="header-content">
                <div>
                    <h1>Categorias</h1>
                    <p>Organize seu catálogo de produtos por grupos lógicos</p>
                </div>

                <button type="button" class="btn-new" onclick="abrirModal()">
                    <span class="material-icons-round">add</span> Nova Categoria
                </button>
            </div>

            <div class="search-container">
                <span class="material-icons-round">search</span>
                <input type="text" id="txtBusca" onkeyup="filtrarCategorias()" placeholder="Procurar categoria pelo nome..." />
            </div>

            <div class="container-categorias">
                <table>
                    <thead>
                        <tr>
                            <th style="width:100px;">ID</th>
                            <th>Nome da Categoria</th>
                            <th style="width:150px; text-align:right;">Ações</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="rptCategorias" runat="server" OnItemCommand="rptCategorias_ItemCommand">
                            <ItemTemplate>
                                <tr>
                                    <td><span class="id-tag">#<%# Eval("IdCategoria") %></span></td>
                                    <td><strong><%# Eval("Nome") %></strong></td>
                                    <td class="td-actions">
                                        <asp:LinkButton
                                            runat="server"
                                            CssClass="btn-delete-action"
                                            CommandName="Excluir"
                                            CommandArgument='<%# Eval("IdCategoria") %>'
                                            OnClientClick="return confirm('Excluir esta categoria? Isso pode afetar produtos vinculados.')">
                                            <span class="material-icons-round">delete_outline</span>
                                        </asp:LinkButton>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>
        </main>

        <!-- MODAL -->
        <div class="modal" id="modalCategoria">
            <div class="modal-content">
                <div class="modal-header">
                    <h2>Nova Categoria</h2>
                    <button type="button" class="close-modal" onclick="fecharModal()">&times;</button>
                </div>

                <div class="form-group">
                    <label>Nome da Categoria</label>
                    <asp:TextBox ID="txtNomeCategoria" runat="server" CssClass="input-ui" placeholder="Ex: Eletrônicos, Calçados..." />
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn-cancel" onclick="fecharModal()">Cancelar</button>
                    <asp:Button ID="btnSalvar" runat="server" Text="Salvar Categoria" OnClick="btnSalvar_Click" CssClass="btn-save-ui" />
                </div>
            </div>
        </div>

    </form>
</body>
</html>