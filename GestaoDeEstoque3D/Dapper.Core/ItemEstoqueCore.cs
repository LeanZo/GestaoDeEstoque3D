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
                ItemEstoque = connection.Query<ItemEstoque, TipoItemEstoque, ItemEstoque>(
                    @"select * from tbl_item_estoque ite
                      inner join tbl_tipo_item_estoque tie on tie_id = ite_tie_id
                      where ite_ativo is true",
                    (ITE, TIE) =>
                    {
                        ITE.TipoItemEstoque = TIE;

                        return ITE;
                    },
                    splitOn: "ite_id, tie_id"
                ).ToList();
            }

            return ItemEstoque;
        }

        public override ItemEstoque RetornarPorId(int id)
        {
            ItemEstoque ItemEstoque;
            using (var connection = DapperConnection.Create())
            {
                ItemEstoque = connection.Query<ItemEstoque, TipoItemEstoque, ItemEstoque>(
                    @"select * from tbl_item_estoque ite
                      inner join tbl_tipo_item_estoque tie on tie_id = ite_tie_id
                      where ite_id = @id
                      limit 1",
                    (ITE, TIE) =>
                    {
                        ITE.TipoItemEstoque = TIE;

                        return ITE;
                    },
                    param: new { id },
                    splitOn: "ite_id, tie_id"
                ).FirstOrDefault();
            }

            return ItemEstoque;
        }
    }
}