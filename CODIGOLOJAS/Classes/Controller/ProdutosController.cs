using CODIGOLOJAS.Classes.models;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;

namespace CODIGOLOJAS.Classes.Controller
{
    public class ProdutosController
    {
        #region Listar Produtos
        public List<Produto> ListarProdutos()
        {
            List<Produto> produtos = new List<Produto>();

            using (MySqlConnection conexao = Database.GetConnection())
            {
                conexao.Open();

                // Usando procedure LISTARPRODUTOS
                MySqlCommand comando = new MySqlCommand("LISTARPRODUTOS", conexao);
                comando.CommandType = System.Data.CommandType.StoredProcedure;

                MySqlDataReader dr = comando.ExecuteReader();

                while (dr.Read())
                {
                    Produto p = new Produto
                    {
                        Id = Convert.ToInt32(dr["id_produto"]),
                        Codigo = dr["cd_produto"].ToString(),
                        Nome = dr["nm_produto"].ToString(),
                        Descricao = dr["ds_produto"]?.ToString(),
                        Valor = Convert.ToDecimal(dr["vl_produto"]),
                        Imagem = dr["img_produto"]?.ToString(),

                        // 🚀 O AJUSTE ESTÁ AQUI:
                        // Sem essa linha, o C# coloca "0" no IdCategoria e o filtro não funciona.
                        IdCategoria = Convert.ToInt32(dr["id_categoria"])
                    };

                    produtos.Add(p);
                }
            }

            return produtos;
        }
        #endregion

        #region Cadastrar Produto
        public void CadastrarProduto(Produto produto)
        {
            using (var conexao = Database.GetConnection())
            {
                conexao.Open();

                MySqlCommand cmd = new MySqlCommand("ADICIONARPRODUTO", conexao);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                // Passando os parâmetros da procedure
                cmd.Parameters.AddWithValue("@p_codigo", produto.Codigo);
                cmd.Parameters.AddWithValue("@p_nome", produto.Nome);
                cmd.Parameters.AddWithValue("@p_descricao", produto.Descricao);
                cmd.Parameters.AddWithValue("@p_valor", produto.Valor);
                cmd.Parameters.AddWithValue("@p_categoria", produto.IdCategoria);
                cmd.Parameters.AddWithValue("@p_imagem", produto.Imagem);

                cmd.ExecuteNonQuery();
            }
        }
        #endregion

        #region Excluir Produto
        public void ExcluirProduto(Produto produto)
        {
            using (var conexao = Database.GetConnection())
            {
                conexao.Open();

                MySqlCommand cmd = new MySqlCommand("REMOVERPRODUTO", conexao);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@p_id", produto.Id);

                cmd.ExecuteNonQuery();
            }
        }
        #endregion

        #region Editar Produto
        public void AtualizarProduto(Produto produto)
        {
            using (MySqlConnection conexao = Database.GetConnection())
            {
                conexao.Open();

                MySqlCommand cmd = new MySqlCommand("ATUALIZARPRODUTO", conexao);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@p_id", produto.Id);
                cmd.Parameters.AddWithValue("@p_codigo", produto.Codigo);
                cmd.Parameters.AddWithValue("@p_nome", produto.Nome);
                cmd.Parameters.AddWithValue("@p_descricao", produto.Descricao);
                cmd.Parameters.AddWithValue("@p_valor", produto.Valor);
                cmd.Parameters.AddWithValue("@p_categoria", produto.IdCategoria);
                cmd.Parameters.AddWithValue("@p_imagem", produto.Imagem);

                try
                {
                    cmd.ExecuteNonQuery();
                }
                catch (MySqlException ex)
                {
                    // DUPLICIDADE DE CÓDIGO
                    if (ex.Message.Contains("uq_cd_produto"))
                    {
                        throw new Exception("Já existe um produto com esse código.");
                    }

                    // FOREIGN KEY
                    if (ex.Message.Contains("fk_categoria_produto"))
                    {
                        throw new Exception("Categoria inválida. Selecione uma categoria existente.");
                    }

                    // OUTROS ERROS
                    throw;
                }
            }
        }

        #endregion
    }
}
