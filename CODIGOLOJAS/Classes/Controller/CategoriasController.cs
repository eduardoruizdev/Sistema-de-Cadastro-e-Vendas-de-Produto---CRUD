using CODIGOLOJAS.Classes.models;
using CODIGOLOJAS.Pages;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CODIGOLOJAS.Classes.Controller
{
    public class CategoriasController
    {

        #region ListarCategorias
        public List<Categoria> listarCategoria()
        {
            List<Categoria> categorias = new List<Categoria>();

            using (MySqlConnection conexao = Database.GetConnection())
            {
                conexao.Open();

                MySqlCommand comando = new MySqlCommand("LISTARCATEGORIAS", conexao);
                comando.CommandType = System.Data.CommandType.StoredProcedure;

                using (MySqlDataReader dr = comando.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        Categoria c = new Categoria
                        {
                            IdCategoria = Convert.ToInt32(dr["id_categoria"]),
                            Nome = dr["nm_categoria"].ToString()
                        };

                        categorias.Add(c);
                    }
                }
            }

            return categorias;
        }
        #endregion

        #region Adicionar Categoria
        public void AddCategoria(Categoria categoria) //funcao pra cadastar uma nova categoria
        {
            using (MySqlConnection conexao = Database.GetConnection()) //me conectando a classe database
            {
                conexao.Open(); //abrindo conexao

                MySqlCommand comando = new MySqlCommand("ADICIONARCATEGORIA", conexao); //executando o comando
                comando.CommandType = System.Data.CommandType.StoredProcedure; //declarando que o comando é uma store procedure

                comando.Parameters.AddWithValue("@p_nome", categoria.Nome); //passando os parametros

                comando.ExecuteNonQuery(); //executando tudo
            }
        }
        #endregion

        public void RemoverCategoria(Categoria categoria) //Funcao pra remover categoria
        {
            using (MySqlConnection conexao = Database.GetConnection()) //se conectando a clase database
            {
                conexao.Open(); //abrindo conexao

                MySqlCommand remover = new MySqlCommand("REMOVERCATEGORIA", conexao); // executando comando
                remover.CommandType = System.Data.CommandType.StoredProcedure; //declarando que é uma store procedure

                remover.Parameters.AddWithValue("@c_id", categoria.IdCategoria); //passando parametros

                int linhas = remover.ExecuteNonQuery(); //criando uma variavel pra ver se o valor da categoria realmente existe

                if (linhas == 0) 
                {
                    // Categoria não encontrada
                }
            }
        }
    }
}