using System;
using System.Collections.Generic;
using System.Linq;
using CODIGOLOJAS.Classes.Controller;
using CODIGOLOJAS.Classes.models;

namespace CODIGOLOJAS.Pages
{
    public partial class index : System.Web.UI.Page
    {
        ProdutosController prodController = new ProdutosController();
        CategoriasController catController = new CategoriasController();

        // Variáveis Públicas para o Banner
        public string AdTitle = "Inovação e Estilo em cada detalhe.";
        public string AdDesc = "Uma curadoria rigorosa de produtos desenvolvidos para quem busca o extraordinário.";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CarregarCategorias();
                ProcessarFiltro();
            }
        }

        private void CarregarCategorias()
        {
            try
            {
                rptCategorias.DataSource = catController.listarCategoria();
                rptCategorias.DataBind();
            }
            catch { }
        }

        private void ProcessarFiltro()
        {
            try
            {
                List<Produto> listaCompleta = prodController.ListarProdutos();
                string catQuery = Request.QueryString["cat"];

                if (!string.IsNullOrEmpty(catQuery) && int.TryParse(catQuery, out int idCat))
                {
                    // Filtra por categoria (Requisito: IdCategoria mapeado na Controller)
                    var filtrados = listaCompleta.Where(p => p.IdCategoria == idCat).ToList();
                    rptProdutos.DataSource = filtrados;

                    // Marketing Dinâmico por Categoria
                    AtualizarMarketing(idCat);
                }
                else
                {
                    rptProdutos.DataSource = listaCompleta;
                }

                rptProdutos.DataBind();
            }
            catch { }
        }

        private void AtualizarMarketing(int idCat)
        {
            switch (idCat)
            {
                case 1: // Exemplo: Moda
                    AdTitle = "Sua nova expressão de estilo.";
                    AdDesc = "Peças exclusivas que unem conforto e as últimas tendências globais.";
                    break;
                case 2: // Exemplo: Tech
                    AdTitle = "Alta Performance Garantida.";
                    AdDesc = "Equipamentos de última geração para quem busca produtividade e imersão.";
                    break;
            }
        }
    }
}