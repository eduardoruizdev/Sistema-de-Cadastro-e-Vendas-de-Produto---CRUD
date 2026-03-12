using System;
using CODIGOLOJAS.Classes.Controller;
using CODIGOLOJAS.Classes.models;
using System.Web.UI.WebControls;

namespace CODIGOLOJAS.Pages
{
    public partial class categorias : System.Web.UI.Page
    {
        CategoriasController controller = new CategoriasController();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CarregarCategorias();
            }
        }

        private void CarregarCategorias()
        {
            rptCategorias.DataSource = controller.listarCategoria();
            rptCategorias.DataBind();
        }

        protected void btnSalvar_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtNomeCategoria.Text))
                return;

            Categoria categoria = new Categoria
            {
                Nome = txtNomeCategoria.Text.Trim()
            };

            controller.AddCategoria(categoria);

            txtNomeCategoria.Text = "";
            CarregarCategorias();
        }

        protected void rptCategorias_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Excluir")
            {
                int id = Convert.ToInt32(e.CommandArgument);

                Categoria categoria = new Categoria
                {
                    IdCategoria = id
                };

                controller.RemoverCategoria(categoria);

                CarregarCategorias();
            }
        }
    }
}
