﻿using GestaoDeEstoque3D.Dapper.Core;
using GestaoDeEstoque3D.Dapper.Model;
using GestaoDeEstoque3D.Models;
using Newtonsoft.Json;
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

        public JsonResult RetornarEstantesNaoPresentesNoMapa()
        {
            var estantes = new EstanteCore().RetornarEstantesNaoPresentesNoMapa();

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
                ArmazemId = 1, //FIX TODO
                Ativo = true
            };

            //Cria poligono da estante
            var camada = new CamadaCore().RetornarPorCamadaNomeArmazemId("Estantes", estante.ArmazemId ?? 1);

            var geojson = GerarGeoJsonEstanteNovo(camada.Id, camada.Nome, -1, estante.LarguraPrateleiras ?? 0, estante.ProfundidadePrateleiras ?? 0);

            var planta2DController = DependencyResolver.Current.GetService<Planta2DController>();
            planta2DController.ControllerContext = new ControllerContext(this.Request.RequestContext, planta2DController);

            var poligonoId = planta2DController.SalvarPoligono(-1, camada.Id, geojson, false);

            estante.PoligonoId = poligonoId;

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
            
            var larguraAnterior = estante.LarguraPrateleiras;
            var profundidadeAnterior = estante.ProfundidadePrateleiras;

            estante.QuantidadePrateleiras = jsonEstante.QtdPrateleiras;
            estante.LarguraPrateleiras = Convert.ToDouble(jsonEstante.LarguraPrat.Replace(',', '.'), CultureInfo.GetCultureInfo("en-US"));
            estante.AlturaPrateleiras = Convert.ToDouble(jsonEstante.AlturaPrat.Replace(',', '.'), CultureInfo.GetCultureInfo("en-US"));
            estante.ProfundidadePrateleiras = Convert.ToDouble(jsonEstante.ProfundidadePrat.Replace(',', '.'), CultureInfo.GetCultureInfo("en-US"));
            estante.PesoMaximoPrateleiras = Convert.ToDouble(jsonEstante.PesoMaximoPrat.Replace(',', '.'), CultureInfo.GetCultureInfo("en-US"));
            estante.UsuarioId = null;
            estante.Ativo = true;

            core.Alterar(estante);

            if (estante.PoligonoId != null)
            {
                var poligonoCore = new PoligonoCore();

                var poligono = poligonoCore.RetornarPorId(estante.PoligonoId ?? 0);

                poligono.Geojson = GerarGeoJsonEstanteAtualizado(poligono.Geojson, larguraAnterior ?? 0, estante.LarguraPrateleiras ?? 0, profundidadeAnterior ?? 0, estante.ProfundidadePrateleiras ?? 0);

                poligonoCore.Alterar(poligono);
            }

            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult DeletarEstante(int EstanteId)
        {
            var core = new EstanteCore();

            var estante = core.RetornarPorId(EstanteId);

            estante.Ativo = false;

            core.Alterar(estante);
            
            if (estante.PoligonoId != null)
            {
                var poligonoCore = new PoligonoCore();

                var poligono = poligonoCore.RetornarPorId(estante.PoligonoId ?? 0);
                
                poligono.Ativo = false;
                
                poligonoCore.Alterar(poligono);
            }

            return Json("", JsonRequestBehavior.AllowGet);
        }

        public void AdicionarEstanteAoMapa(int EstanteId)
        {
            var estante = new EstanteCore().RetornarPorId(EstanteId);
            var poligono = new PoligonoCore().RetornarPorId(estante.PoligonoId ?? 0);
            
            poligono.Ativo = true;

            new PoligonoCore().Alterar(poligono);
        }

        public static string GerarGeoJsonEstanteNovo(int CamadaId, string CamadaNome, int PoligonoId, double Largura, double Profundidade)
        {
             return "{ \"type\":\"Feature\",\"properties\":{ \"PoligonoId\":\"-1\",\"CamadaId\":\"" + CamadaId + "\",\"CamadaNome\":\"" + CamadaNome + "\"},\"geometry\":{ \"type\":\"Polygon\",\"coordinates\":[[[0,0],[" + Largura + ",0],[" + Largura + "," + Profundidade + "],[0," + Profundidade + "],[0,0]]]}}";
        }

        public static string GerarGeoJsonEstanteAtualizado(string Geojson, double LarguraAnterior, double LarguraNova, double ProfundidadeAnterior, double ProfundidadeNova)
        {
            var geojsonObjeto = JsonConvert.DeserializeObject<PoligonoGeojson>(Geojson);

            var LarguraDiferenca = LarguraNova - LarguraAnterior;
            var ProfundidadeDiferenca = ProfundidadeNova - ProfundidadeAnterior;

            //geojsonObjeto.geometry.coordinates[0][1][0]
            geojsonObjeto.geometry.coordinates[0][1][0] += LarguraDiferenca;
            geojsonObjeto.geometry.coordinates[0][2][0] += LarguraDiferenca;
            geojsonObjeto.geometry.coordinates[0][2][1] += ProfundidadeDiferenca;
            geojsonObjeto.geometry.coordinates[0][3][1] += ProfundidadeDiferenca;
            //geojsonObjeto.geometry.coordinates[0][3][1]

            return JsonConvert.SerializeObject(geojsonObjeto);
        }
    }
}