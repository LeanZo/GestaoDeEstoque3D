var tabelaEstantes = new Tabulator("#tabela-estantes", {
    columns: [
        { title: "Código", field: "Id" },
        { title: "Qtd. de Prateleiras", field: "QtdPrateleiras" },
        { title: "Largura das Prat.", field: "LarguraPrat" },
        { title: "Altura das Prat.", field: "AlturaPrat" },
        { title: "Profundidade das Prat.", field: "ProfundidadePrat" },
        { title: "Peso Máximo das Prat.", field: "PesoMaximoPrat" },
        { title: "Opções", field: "Opcoes" },
    ],
});

$(function () {
    CarregarTabelaEstantes();
});

function CarregarTabelaEstantes() {
    $.ajax({
        type: "POST",
        url: "/Estante/RetornarEstantes",
        success: function (result) {
            tabelaEstantes.setData(result);
        },
        error: function (req, status, error) {
            console.log("Erro.");
        }
    });
}

function CadastrarEstante() {
    var json = {};

    json.QtdPrateleiras = $('#estante-quantidade-prateleiras').val();
    json.LarguraPrat = $('#estante-largura-prateleiras').val();
    json.AlturaPrat = $('#estante-altura-prateleiras').val();
    json.ProfundidadePrat = $('#estante-profundidade-prateleiras').val();
    json.PesoMaximoPrat = $('#estante-peso-maximo-prateleiras').val();

    var parametrosAjax = { JsonEstante: JSON.stringify(json) };
    $.ajax({
        type: "POST",
        url: "/Estante/CadastrarEstante",
        data: parametrosAjax,
        success: function (result) {
            CarregarTabelaEstantes();
        },
        error: function (req, status, error) {
            console.log("Erro.");
        }
    });
}