using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CODIGOLOJAS.Classes.models
{
    public class Produto
    {
       
        public int Id { get; set; }
        public string Codigo { get; set; }

        public string Nome { get; set; }

        public string Descricao { get; set; }

        public decimal Valor { get; set; }

        // FK para categoria
        public int IdCategoria { get; set; }

        public string Imagem { get; set; }

        // Construtor padrão
        public Produto() { }

        // Construtor completo
        public Produto(int id, string codigo, string nome, string descricao, decimal valor, int idCategoria, string imagem)
        {
            Id = id;
            Codigo = codigo;
            Nome = nome;
            Descricao = descricao;
            Valor = valor;
            IdCategoria = idCategoria;
            Imagem = imagem;
        }
    }
}
