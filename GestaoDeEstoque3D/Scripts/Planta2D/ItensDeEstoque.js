let AcoesRowItensDeEstoque = function (cell, formatterParams, onRendered) {
    //return '<div style="display: flex"><div style="color: #219BB8;" onclick="AdicionarEstanteAoMapa(' + cell.getData().Id + ')">Adicionar</div></div>';
    return '<div style="display: flex"><div style="color: #219BB8;" onclick="ItensDeEstoque.Estocar(' + cell.getData().Id + ')">Estocar</div></div>';
};

var tabelaItensDeEstoque = new Tabulator("#tabela-modal-itens-de-estoque", {
        columns: [
        { title: "Código", field: "Id" },
        { title: "Nome", field: "Nome" },
        { title: "Descrição", field: "Descricao" },
        { title: "Código de Barras", field: "CodigoDeBarras" },
        { title: "Largura.", field: "Largura" },
        { title: "Altura", field: "Altura" },
        { title: "Profundidade", field: "Profundidade" },
        { title: "Peso", field: "Peso" },
        { title: "Peso Máximo p/ Empilhamento", field: "PesoMaximoEmpilhamento" },
        { title: "Ações", field: "Acoes", formatter: AcoesRowItensDeEstoque },
        ],
});

class ItensDeEstoque {
    static CarregarTabelaItensDeEstoque() {
        $.ajax({
            type: "POST",
            url: "/TipoItemEstoque/RetornarTiposItemEstoque",
            success: function (result) {
                tabelaItensDeEstoque.setData(result);
                tabelaItensDeEstoque.redraw(true);
            },
            error: function (req, status, error) {
                console.log("Erro.");
            }
        });
    }

    static AbrirModalEstocar() {
        this.CarregarTabelaItensDeEstoque();

        $('#ModaItensDeEstoque-Header').text('Itens de Estoque - Estocar');

        $('#ModaItensDeEstoque').css('display', 'flex');
    }

    static Estocar(TipoItemEstoqueId) {
        $.ajax({
            type: "POST",
            url: "/ControleDeEstoque/EstocarNovoItem",
            data: { TipoItemEstoqueId: TipoItemEstoqueId },
            success: async function (result) {
                if (result.NovoItemId != -1) {
                    await PackContainers();

                    view3D.UnpackAllItemsInRender();

                    var containerPackingResult = ContainerPackingResult.find(elem => elem.ContainerID == result.EstanteId);

                    if (containerPackingResult != null) {
                        view3D.ShowPackingView(containerPackingResult, result.NovoItemId);
                        view3D.PackAllItemsInRender();
                    }

                    $('#ModaItensDeEstoque').css('display', 'none');
                    $('#ModalItensDeEstoque').css('display', 'none');
                }
            },
            error: function (req, status, error) {
                console.log("Erro.");
            }
        });
    }
}
