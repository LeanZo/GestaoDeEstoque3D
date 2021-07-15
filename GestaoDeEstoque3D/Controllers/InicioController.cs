using CromulentBisgetti.ContainerPacking;
using CromulentBisgetti.ContainerPacking.Entities;
using GestaoDeEstoque3D.Dapper.Core;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GestaoDeEstoque3D.Controllers
{
    public class InicioController : Controller
    {
        // GET: Inicio
        public ActionResult Index()
        {
            return View();
        }

        public JsonResult ContainerPacking()
        {

            var Estantes = new EstanteCore().RetornarTodos();
            var ItemEstoque = new ItemEstoqueCore().RetornarTodos();

            var Containers = new List<Container>();
            var ItemsToPack = new List<Item>();
            var AlgorithmTypeIDs = new List<int>();

            Estantes.ForEach(est =>
            {
                Containers.Add(new Container(est.Id, Convert.ToDecimal(est.ProfundidadePrateleiras), Convert.ToDecimal(est.LarguraPrateleiras), Convert.ToDecimal(est.AlturaPrateleiras)));
            });

            var query = ItemEstoque
            .GroupBy(c => c.TipoItemEstoqueId)
            .Select(o => new Item(o.Key ?? 0, Convert.ToDecimal(o.FirstOrDefault().TipoItemEstoque.Largura), Convert.ToDecimal(o.FirstOrDefault().TipoItemEstoque.Altura),
            Convert.ToDecimal(o.FirstOrDefault().TipoItemEstoque.Profundidade), o.Count(c => c.Ativo))
            ).ToList();

            ItemsToPack.AddRange(query);

            AlgorithmTypeIDs.Add(1);

            var PackResult = PackingService.Pack(Containers, ItemsToPack, AlgorithmTypeIDs);

            var response = new
            {
                PackResult,
                Containers
            };

            return Json(response);
        }
    }
}