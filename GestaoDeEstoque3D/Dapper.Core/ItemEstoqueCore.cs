using Dapper;
using GestaoDeEstoque3D.Dapper.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GestaoDeEstoque3D.Dapper.Core
{
    public class ItemEstoqueCore : TabelaBaseCore<ItemEstoque>
    {
        public List<ItemEstoque> RetornarTodos()
        {
            List<ItemEstoque> ItemEstoque;
            using (var connection = DapperConnection.Create())
            {
                ItemEstoque = connection.Query<ItemEstoque>(
                    @"select * from tbl_item_estoque ite
                      where ite_ativo is true"
                ).ToList();
            }

            return ItemEstoque;
        }

        public override ItemEstoque RetornarPorId(int id)
        {
            ItemEstoque ItemEstoque;
            using (var connection = DapperConnection.Create())
            {
                ItemEstoque = connection.Query<ItemEstoque>(
                    @"select * from tbl_item_estoque ite
                      where ite_id = @id
                      limit 1",
                    param: new { id }
                ).FirstOrDefault();
            }

            return ItemEstoque;
        }
    }
}