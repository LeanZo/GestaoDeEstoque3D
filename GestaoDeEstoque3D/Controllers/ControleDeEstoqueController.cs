using GestaoDeEstoque3D.Dapper.Core;
using GestaoDeEstoque3D.Dapper.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace GestaoDeEstoque3D.Controllers
{
    public class ControleDeEstoqueController : Controller
    {
        // GET: ControleDeEstoque
        public JsonResult EstocarNovoItem(int TipoItemEstoqueId)
        {
            //===Carrega containers/estantes=====================
            var estanteCore = new EstanteCore();
            var itemEstoqueCore = new ItemEstoqueCore();
            var estantes = estanteCore.RetornarTodosComItens();

            var containers = new List<OnlineContainerPacking.Models.Container>();
            estantes.OrderBy(e => e.Id).ToList().ForEach(estante =>
            {
                var items = new List<OnlineContainerPacking.Models.Item>();
                estante.ItemsEstoque.OrderByDescending(i => i.PackY).ToList().ForEach(itemEstoque => {
                    var TipoItemEstoque = itemEstoque.TipoItemEstoque;
                    var _itemContainerPacking = new OnlineContainerPacking.Models.Item(itemEstoque.Id, Convert.ToDecimal(TipoItemEstoque.Largura), Convert.ToDecimal(TipoItemEstoque.Altura), Convert.ToDecimal(TipoItemEstoque.Profundidade), Convert.ToDecimal(itemEstoque.PackX), Convert.ToDecimal(itemEstoque.PackY), Convert.ToDecimal(itemEstoque.PackZ), 1, TipoItemEstoque.Id, itemEstoque.ItemBaseId);

                    if (itemEstoque.PackY == 0) //É um item base
                    {
                        _itemContainerPacking.ItensEmpilhados = items.Where(i => i.ItemBaseId == _itemContainerPacking.ID).OrderBy(i => i.CoordY).ToList();

                        if (Convert.ToDecimal(estante.AlturaPrateleiras) < _itemContainerPacking.Dim2 * (_itemContainerPacking.ItensEmpilhados.Count + 2))
                        {
                            _itemContainerPacking.EmpilhamentoDisponivel = false;
                        }
                    }

                    _itemContainerPacking.IsPacked = true;
                    items.Add(_itemContainerPacking);
                });

                containers.Add(new OnlineContainerPacking.Models.Container(estante.Id, Convert.ToDecimal(estante.ProfundidadePrateleiras), Convert.ToDecimal(estante.LarguraPrateleiras), Convert.ToDecimal(estante.AlturaPrateleiras), items));
            });
            //=====================================================

            var tipoItemEstoque = new TipoItemEstoqueCore().RetornarPorId(TipoItemEstoqueId);
            var novoItem = new OnlineContainerPacking.Models.Item(-1, Convert.ToDecimal(tipoItemEstoque.Largura), Convert.ToDecimal(tipoItemEstoque.Altura), Convert.ToDecimal(tipoItemEstoque.Profundidade), 1, tipoItemEstoque.Id);
            
            var itemsToPack = new List<OnlineContainerPacking.Models.Item>();
            itemsToPack.Add(novoItem);

            OnlineContainerPacking.PackingService.OnlinePack(containers, itemsToPack);

            ItemEstoque novoItemEstoque = null;
            if (novoItem.IsPacked)
            {
            //Parallel.ForEach(itemsToPack.Where(i => i.IsPacked).ToList(), i =>
            //{
                var itemEstoque = new ItemEstoque()
                {
                    ItemBaseId = novoItem.ItemBaseId,
                    EstanteId = novoItem.ContainerId,
                    PackX = Convert.ToDouble(novoItem.CoordX),
                    PackY = Convert.ToDouble(novoItem.CoordY),
                    PackZ = Convert.ToDouble(novoItem.CoordZ),
                    TipoItemEstoqueId = novoItem.TipoDeItemId,
                    DataHora = DateTime.Now,
                    UsuarioId = null,
                    Ativo = true
                };

                itemEstoqueCore.Inserir(itemEstoque);

                novoItemEstoque = itemEstoque;
            //});
            }

            var response = new
            {
                NovoItemId = novoItemEstoque == null ? -1 : novoItemEstoque.Id,
                EstanteId = novoItemEstoque == null ? -1 : novoItemEstoque.EstanteId
            };

            return Json(response);
        }

        public JsonResult RetirarItem(int TipoItemEstoqueId)
        {
            var itemEstoqueCore = new ItemEstoqueCore();

            var itemEstoque = itemEstoqueCore.RetornarUltimoAssociadoPorTipoId(TipoItemEstoqueId);
            var estanteId = itemEstoque.EstanteId;

            itemEstoque.EstanteId = null;
            itemEstoqueCore.Alterar(itemEstoque);

            var response = new
            {
                ItemId = itemEstoque.Id,
                EstanteId = estanteId ?? -1
            };

            return Json(response);
        }
    }
}