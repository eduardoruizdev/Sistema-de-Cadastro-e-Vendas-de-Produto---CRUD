using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CODIGOLOJAS.Pages
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string login = txtUsuario.Text.Trim();
            string senha = txtSenha.Text.Trim();

            if( login == "" || senha == "")
            {
                lblMensagem.Text = "Login/Senha não podem ser nulos, preencha os campos!";
                return;
            }

            using(var conexao = Database.GetConnection())
            {
                conexao.Open();
                MySqlCommand comando = new MySqlCommand(@"SELECT id_usuario
                                                        FROM usuario
                                                        WHERE nm_login_usuario = @nome
                                                          AND nm_senha_usuario = SHA2(@senha, 256);
                                                        ", conexao);

                comando.Parameters.AddWithValue("@nome", login);
                comando.Parameters.AddWithValue("@senha", senha);

              

                object resultado = comando.ExecuteScalar();

                if (resultado != null)
                {
                    Session["usuario"] = login;
                    Response.Redirect("~/Pages/Gerenciadoestoq.aspx");
                }
                else
                {
                    lblMensagem.Text = "Login ou senha inválidos";
                }
            }
        }
    }
}