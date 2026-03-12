<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="CODIGOLOJAS.Pages.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Painel Administrativo | Login</title>

    <!-- CSS -->
    <link href="~/style/styleLogin.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container">

            <div class="login-card">
                <h1>Painel Administrativo</h1>
                <p>Faça login para continuar</p>

                <div class="input-group">
                    <label>Usuário</label>
                    <asp:TextBox ID="txtUsuario" runat="server" CssClass="input" placeholder="Digite seu usuário"></asp:TextBox>
                </div>

                <div class="input-group">
                    <label>Senha</label>
                    <asp:TextBox ID="txtSenha" runat="server" CssClass="input" TextMode="Password" placeholder="Digite sua senha"></asp:TextBox>
                </div>

                <asp:Button ID="btnLogin" runat="server" Text="Entrar" CssClass="btn-login" onclick="btnLogin_Click"/>

                <asp:Label ID="lblMensagem" runat="server" CssClass="mensagem"></asp:Label>
            </div>

        </div>
    </form>
</body>
</html>
