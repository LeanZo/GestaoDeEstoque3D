using Dapper;
using GestaoDeEstoque3D.Dapper.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;

namespace GestaoDeEstoque3D.Dapper.Core
{
    public class EstanteCore : TabelaBaseCore<Estante>
    {
        public List<Estante> RetornarTodos(int ArmazemId = 1)
        {
            List<Estante> Estante;
            using (var connection = DapperConnection.Create())
            {
                Estante = connection.Query<Estante>(
                    @"select * from tbl_estante est
                      where est_ativo is true and est_arm_id = @ArmazemId",
                    new { ArmazemId }
                ).ToList();
            }

            return Estante;
        }

        public List<Estante> RetornarTodosComItens(int ArmazemId = 1)
        {
            List<Estante> Estante;
            using (var connection = DapperConnection.Create())
            {
                Estante = connection.Query<Estante>(
                    @"select * from tbl_estante est
                      where est_ativo is true and est_arm_id = @ArmazemId",
                    new { ArmazemId }
                ).ToList();
            }

            var itemEstoqueCore = new ItemEstoqueCore();
            Parallel.ForEach(Estante, estante =>
            {
                estante.ItemsEstoque = itemEstoqueCore.RetornarPorEstanteId(estante.Id);
            });

            return Estante;
        }

        public List<Estante> RetornarEstantesNaoPresentesNoMapa(int ArmazemId = 1)
        {
            List<Estante> Estante;
            using (var connection = DapperConnection.Create())
            {
                Estante = connection.Query<Estante>(
                    @"select * from tbl_estante est
                      inner join tbl_poligono pol on est_pol_id = pol_id and pol_ativo is false
                      where est_ativo is true and est_arm_id = @ArmazemId",
                    new { ArmazemId }
                ).ToList();
            }

            return Estante;
        }

        public List<Estante> RetornarEstantesAssociadas()
        {
            List<Estante> Estante;
            using (var connection = DapperConnection.Create())
            {
                Estante = connection.Query<Estante>(
                    @"select * from tbl_estante est
                      where est_ativo is true and est_pol_id is not null"
                ).ToList();
            }

            return Estante;
        }

        public override Estante RetornarPorId(int id)
        {
            Estante Estante;
            using (var connection = DapperConnection.Create())
            {
                Estante = connection.Query<Estante>(
                    @"select * from tbl_estante est
                      where est_id = @id
                      limit 1",
                    param: new { id }
                ).FirstOrDefault();
            }

            return Estante;
        }
    }
}