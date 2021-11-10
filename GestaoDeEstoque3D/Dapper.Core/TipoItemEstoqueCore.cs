using Dapper;
using GestaoDeEstoque3D.Dapper.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GestaoDeEstoque3D.Dapper.Core
{
    public class TipoItemEstoqueCore : TabelaBaseCore<TipoItemEstoque>
    {
        public List<TipoItemEstoque> RetornarTodosAssociados()
        {
            List<TipoItemEstoque> TipoItemEstoque;
            using (var connection = DapperConnection.Create())
            {
                TipoItemEstoque = connection.Query<TipoItemEstoque>(
                    @"select * from tbl_tipo_item_estoque tie
                      where tie_ativo is true 
                      and exists (select 1 from tbl_item_estoque where ite_tie_id = tie_id and ite_est_id is not null limit 1)
                      order by tie_nome"
                ).ToList();
            }

            return TipoItemEstoque;
        }
        
        public List<TipoItemEstoque> RetornarTodos()
        {
            List<TipoItemEstoque> TipoItemEstoque;
            using (var connection = DapperConnection.Create())
            {
                TipoItemEstoque = connection.Query<TipoItemEstoque>(
                    @"select * from tbl_tipo_item_estoque tie
                      where tie_ativo is true
                      order by tie_nome"
                ).ToList();
            }

            return TipoItemEstoque;
        }

        public override TipoItemEstoque RetornarPorId(int id)
        {
            TipoItemEstoque TipoItemEstoque;
            using (var connection = DapperConnection.Create())
            {
                TipoItemEstoque = connection.Query<TipoItemEstoque>(
                    @"select * from tbl_tipo_item_estoque tie
                      where tie_id = @id
                      limit 1",
                    param: new { id }
                ).FirstOrDefault();
            }

            return TipoItemEstoque;
        }
    }
}