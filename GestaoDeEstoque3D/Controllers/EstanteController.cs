using GestaoDeEstoque3D.Dapper.Core;
using GestaoDeEstoque3D.Dapper.Model;
using GestaoDeEstoque3D.Models;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GestaoDeEstoque3D.Controllers
{
    public class EstanteController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        public JsonResult RetornarEstantes()
        {
            var estantes = new EstanteCore().RetornarTodos();

            var response = estantes.Select(est => new
            {
                Id = est.Id,
                QtdPrateleiras = est.QuantidadePrateleiras,
                LarguraPrat = est.LarguraPrateleiras,
                AlturaPrat = est.AlturaPrateleiras,
                ProfundidadePrat = est.ProfundidadePrateleiras,
                PesoMaximoPrat = est.PesoMaximoPrateleiras,
            });

            var return_json = Json(response, JsonRequestBehavior.AllowGet);
            return_json.MaxJsonLength = int.MaxValue;
            return return_json;
        }

        public JsonResult CadastrarEstante(string JsonEstante)
        {
            var definition = new
            {
                QtdPrateleiras = new int(),
                LarguraPrat = "",
                AlturaPrat = "",
                ProfundidadePrat = "",
                PesoMaximoPrat = "",
            };

            var jsonEstante = Newtonsoft.Json.JsonConvert.DeserializeAnonymousType(JsonEstante, definition);

            var estante = new Estante()
            {
                QuantidadePrateleiras = jsonEstante.QtdPrateleiras,
                LarguraPrateleiras = Convert.ToDouble(jsonEstante.LarguraPrat.Replace(',', '.'), CultureInfo.GetCultureInfo("en-US")),
                AlturaPrateleiras = Convert.ToDouble(jsonEstante.AlturaPrat.Replace(',', '.'), CultureInfo.GetCultureInfo("en-US")),
                ProfundidadePrateleiras = Convert.ToDouble(jsonEstante.ProfundidadePrat.Replace(',', '.'), CultureInfo.GetCultureInfo("en-US")),
                PesoMaximoPrateleiras = Convert.ToDouble(jsonEstante.PesoMaximoPrat.Replace(',', '.'), CultureInfo.GetCultureInfo("en-US")),
                PoligonoId = null,
                UsuarioId = null,
                Ativo = true
            };

            new EstanteCore().Inserir(estante);

            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult EditarEstante(string JsonEstante)
        {
            var definition = new
            {
                Id = new int(),
                QtdPrateleiras = new int(),
                LarguraPrat = "",
                AlturaPrat = "",
                ProfundidadePrat = "",
                PesoMaximoPrat = "",
            };

            var jsonEstante = Newtonsoft.Json.JsonConvert.DeserializeAnonymousType(JsonEstante, definition);

            var core = new EstanteCore();

            var estante = core.RetornarPorId(jsonEstante.Id);

            estante.QuantidadePrateleiras = jsonEstante.QtdPrateleiras;
            estante.LarguraPrateleiras = Convert.ToDouble(jsonEstante.LarguraPrat.Replace(',', '.'), CultureInfo.GetCultureInfo("en-US"));
            estante.AlturaPrateleiras = Convert.ToDouble(jsonEstante.AlturaPrat.Replace(',', '.'), CultureInfo.GetCultureInfo("en-US"));
            estante.ProfundidadePrateleiras = Convert.ToDouble(jsonEstante.ProfundidadePrat.Replace(',', '.'), CultureInfo.GetCultureInfo("en-US"));
            estante.PesoMaximoPrateleiras = Convert.ToDouble(jsonEstante.PesoMaximoPrat.Replace(',', '.'), CultureInfo.GetCultureInfo("en-US"));
            estante.UsuarioId = null;
            estante.Ativo = true;

            core.Alterar(estante);

            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult DeletarEstante(int EstanteId)
        {
            var core = new EstanteCore();

            var estante = core.RetornarPorId(EstanteId);

            estante.Ativo = false;

            core.Alterar(estante);

            return Json("", JsonRequestBehavior.AllowGet);
        }
    }
}