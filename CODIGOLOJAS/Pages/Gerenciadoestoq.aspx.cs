using CODIGOLOJAS.Classes.Controller;
using CODIGOLOJAS.Classes.models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web.UI;
using System.Globalization;

namespace CODIGOLOJAS.Pages
{
    public partial class Gerenciadoestoq : System.Web.UI.Page
    {
        ProdutosController controller = new ProdutosController();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CarregarCategorias();
                CarregarProdutos();
            }
        }

        private void CarregarProdutos()
        {
            rptProdutos.DataSource = controller.ListarProdutos();
            rptProdutos.DataBind();
        }

        private void CarregarCategorias()
        {
            CategoriasController catController = new CategoriasController();
            ddlCategoria.DataSource = catController.listarCategoria();
            ddlCategoria.DataTextField = "Nome";
            ddlCategoria.DataValueField = "IdCategoria";
            ddlCategoria.DataBind();
            ddlCategoria.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Selecione uma categoria", "0"));
        }

        // 🚀 MÉTODO MÁGICO DE CONVERSÃO DE PREÇO
        private decimal ConverterPreco(string input)
        {
            if (string.IsNullOrWhiteSpace(input)) return 0;
            input = input.Trim();

            // 1. Se tem ponto e vírgula (ex: 1.500,00), limpa os pontos e usa a vírgula como decimal
            if (input.Contains(".") && input.Contains(","))
                return decimal.Parse(input.Replace(".", "").Replace(",", "."), CultureInfo.InvariantCulture);

            // 2. Se tem apenas UM separador e ele é seguido por EXATAMENTE 3 dígitos (ex: 3.600 ou 3,600)
            // Tratamos como milhar.
            int lastSep = Math.Max(input.LastIndexOf('.'), input.LastIndexOf(','));
            if (lastSep != -1 && (input.Length - lastSep - 1) == 3)
                return decimal.Parse(input.Replace(".", "").Replace(",", ""), CultureInfo.InvariantCulture);

            // 3. Caso contrário, trata o separador como decimal (ex: 3,50 ou 3.50)
            return decimal.Parse(input.Replace(",", "."), CultureInfo.InvariantCulture);
        }

        protected void btnSalvar_Click(object sender, EventArgs e)
        {
            if (ddlCategoria.SelectedValue == "0") return;

            string imagemFinal = hfImagemAtual.Value;
            if (fileUploadImagem.HasFile)
            {
                string nomeArquivo = Guid.NewGuid() + Path.GetExtension(fileUploadImagem.FileName);
                imagemFinal = "/img/produtos/" + nomeArquivo;
                fileUploadImagem.SaveAs(Server.MapPath(imagemFinal));
            }

            Produto produto = new Produto
            {
                Codigo = txtCodigo.Text,
                Nome = txtNome.Text,
                Descricao = txtDescricao.Text,
                Valor = ConverterPreco(txtPreco.Text), // Usa a conversão inteligente
                IdCategoria = int.Parse(ddlCategoria.SelectedValue),
                Imagem = imagemFinal
            };

            if (string.IsNullOrEmpty(hfIdProduto.Value))
                controller.CadastrarProduto(produto);
            else
            {
                produto.Id = int.Parse(hfIdProduto.Value);
                controller.AtualizarProduto(produto);
            }

            LimparCampos();
            CarregarProdutos();
        }

        protected void EditarProduto_Click(object sender, System.Web.UI.WebControls.CommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);
            Produto p = controller.ListarProdutos().FirstOrDefault(x => x.Id == id);
            if (p == null) return;

            hfIdProduto.Value = p.Id.ToString();
            hfImagemAtual.Value = p.Imagem;
            txtCodigo.Text = p.Codigo.ToString();
            txtNome.Text = p.Nome;
            txtDescricao.Text = p.Descricao;

            // Exibe formatado para o usuário
            txtPreco.Text = p.Valor.ToString("N2", new CultureInfo("pt-BR"));

            ddlCategoria.SelectedValue = p.IdCategoria.ToString();
            ScriptManager.RegisterStartupScript(this, GetType(), "modal", "abrirModal('modalCadastro');", true);
        }

        protected void ExcluirProduto_Click(object sender, System.Web.UI.WebControls.CommandEventArgs e)
        {
            controller.ExcluirProduto(new Produto { Id = Convert.ToInt32(e.CommandArgument) });
            CarregarProdutos();
        }

        private void LimparCampos()
        {
            hfIdProduto.Value = ""; hfImagemAtual.Value = "";
            txtCodigo.Text = ""; txtNome.Text = ""; txtDescricao.Text = ""; txtPreco.Text = "";
            ddlCategoria.SelectedIndex = 0;
        }
    }
}