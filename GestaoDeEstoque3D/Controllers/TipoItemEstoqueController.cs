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
    public class TipoItemEstoqueController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        public JsonResult RetornarTiposItemEstoque()
        {
            var tiposItemEstoque = new TipoItemEstoqueCore().RetornarTodos();

            var response = tiposItemEstoque.Select(est => new
            {
                Id = est.Id,
                Nome = est.Nome,
                Descricao = est.Descricao,
                Largura = est.Largura,
                Altura = est.Altura,
                Profundidade = est.Profundidade,
                Peso = est.Peso,
                PesoMaximoEmpilhamento = est.PesoMaximoEmpilhamento,
                CodigoDeBarras = est.CodigoDeBarras,
            });

            var return_json = Json(response, JsonRequestBehavior.AllowGet);
            return_json.MaxJsonLength = int.MaxValue;
            return return_json;
        }

        public JsonResult CadastrarTipoItemEstoque(string JsonTipoItemEstoque)
        {
            var definition = new
            {
                Nome = "",
                Descricao = "",
                Largura = "",
                Altura = "",
                Profundidade = "",
                Peso = "",
                PesoMaximoEmpilhamento = "",
                CodigoDeBarras = "",
            };

            var jsonTipoItemEstoque = Newtonsoft.Json.JsonConvert.DeserializeAnonymousType(JsonTipoItemEstoque, definition);

            var tipoItemEstoque = new TipoItemEstoque()
            {
                Nome = jsonTipoItemEstoque.Nome,
                Descricao = jsonTipoItemEstoque.Descricao,
                Largura = Convert.ToDouble(jsonTipoItemEstoque.Largura.Replace(',', '.'), CultureInfo.GetCultureInfo("en-US")),
                Altura = Convert.ToDouble(jsonTipoItemEstoque.Altura.Replace(',', '.'), CultureInfo.GetCultureInfo("en-US")),
                Profundidade = Convert.ToDouble(jsonTipoItemEstoque.Profundidade.Replace(',', '.'), CultureInfo.GetCultureInfo("en-US")),
                Peso = Convert.ToDouble(jsonTipoItemEstoque.Peso.Replace(',', '.'), CultureInfo.GetCultureInfo("en-US")),
                PesoMaximoEmpilhamento = Convert.ToDouble(jsonTipoItemEstoque.PesoMaximoEmpilhamento.Replace(',', '.'), CultureInfo.GetCultureInfo("en-US")),
                CodigoDeBarras = jsonTipoItemEstoque.CodigoDeBarras,
                UsuarioId = null,
                DataHora = DateTime.Now,
                Ativo = true,
            };

            new TipoItemEstoqueCore().Inserir(tipoItemEstoque);

            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult EditarTipoItemEstoque(string JsonTipoItemEstoque)
        {
            var definition = new
            {
                Id = new int(),
                Nome = "",
                Descricao = "",
                Largura = "",
                Altura = "",
                Profundidade = "",
                Peso = "",
                PesoMaximoEmpilhamento = "",
                CodigoDeBarras = "",
            };

            var jsonTipoItemEstoque = Newtonsoft.Json.JsonConvert.DeserializeAnonymousType(JsonTipoItemEstoque, definition);

            var core = new TipoItemEstoqueCore();

            var TipoItemEstoque = core.RetornarPorId(jsonTipoItemEstoque.Id);

            TipoItemEstoque.Nome = jsonTipoItemEstoque.Nome;
            TipoItemEstoque.Descricao = jsonTipoItemEstoque.Descricao;
            TipoItemEstoque.Largura = Convert.ToDouble(jsonTipoItemEstoque.Largura.Replace(',', '.'), CultureInfo.GetCultureInfo("en-US"));
            TipoItemEstoque.Altura = Convert.ToDouble(jsonTipoItemEstoque.Altura.Replace(',', '.'), CultureInfo.GetCultureInfo("en-US"));
            TipoItemEstoque.Profundidade = Convert.ToDouble(jsonTipoItemEstoque.Profundidade.Replace(',', '.'), CultureInfo.GetCultureInfo("en-US"));
            TipoItemEstoque.Peso = Convert.ToDouble(jsonTipoItemEstoque.Peso.Replace(',', '.'), CultureInfo.GetCultureInfo("en-US"));
            TipoItemEstoque.PesoMaximoEmpilhamento = Convert.ToDouble(jsonTipoItemEstoque.PesoMaximoEmpilhamento.Replace(',', '.'), CultureInfo.GetCultureInfo("en-US"));
            TipoItemEstoque.CodigoDeBarras = jsonTipoItemEstoque.CodigoDeBarras;
            TipoItemEstoque.UsuarioId = null;
            TipoItemEstoque.DataHora = DateTime.Now;
            TipoItemEstoque.Ativo = true;

            core.Alterar(TipoItemEstoque);

            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult DeletarTipoItemEstoque(int TipoItemEstoqueId)
        {
            var core = new TipoItemEstoqueCore();

            var TipoItemEstoque = core.RetornarPorId(TipoItemEstoqueId);

            TipoItemEstoque.Ativo = false;

            core.Alterar(TipoItemEstoque);
            
            return Json("", JsonRequestBehavior.AllowGet);
        }
    }
}