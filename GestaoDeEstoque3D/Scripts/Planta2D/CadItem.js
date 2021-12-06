class CadItem {
    static Abrir(id = null) {
        this.Limpar();

        $('#modal-cadastro-item').css('display', 'flex');

        if (id != null)
            this.Carregar(id);
    }

    static Fechar() {
        $('#modal-cadastro-item').css('display', 'none');
    }

    static Limpar() {
        $('#modal-cadastro-item input').val('');
    }

    static Carregar(id) {
        var data = ModalLista.Objetos.find(i => i.Id == id);

        $('#cad-item-id').val(data.Id);
        $('#cad-item-nome').val(data.Nome);
        $('#cad-item-descricao').val(data.Descricao);
        $('#cad-item-largura').val(data.Largura);
        $('#cad-item-altura').val(data.Altura);
        $('#cad-item-profundidade').val(data.Profundidade);
        $('#cad-item-peso').val(data.Peso);
        $('#cad-item-peso-maximo').val(data.PesoMaximoEmpilhamento);
        $('#cad-item-codigo-barras').val(data.CodigoDeBarras);
    }

    static Finalizar() {
        if ($('#cad-item-id').val() == '')
            this.Cadastrar();
        else
            this.Editar();
    }

    static Cadastrar() {
        var json = {};

        json.Nome = $('#cad-item-nome').val();
        json.Descricao = $('#cad-item-descricao').val();
        json.Largura = $('#cad-item-largura').val();
        json.Altura = $('#cad-item-altura').val();
        json.Profundidade = $('#cad-item-profundidade').val();
        json.Peso = $('#cad-item-peso').val();
        json.PesoMaximoEmpilhamento = $('#cad-item-peso-maximo').val();
        json.CodigoDeBarras = $('#cad-item-codigo-barras').val();

        var parametrosAjax = { JsonTipoItemEstoque: JSON.stringify(json) };
        $.ajax({
            type: "POST",
            url: "/TipoItemEstoque/CadastrarTipoItemEstoque",
            data: parametrosAjax,
            success: function (result) {
                ModalLista.ItensDeEstoque.Carregar(() => { ModalLista.Filtrar(); });
                CadItem.Fechar();
            },
            error: function (req, status, error) {
                console.log("Erro.");
            }
        });
    }

    static Editar() {
        var json = {};

        json.Id = $('#cad-item-id').val();
        json.Nome = $('#cad-item-nome').val();
        json.Descricao = $('#cad-item-descricao').val();
        json.Largura = $('#cad-item-largura').val();
        json.Altura = $('#cad-item-altura').val();
        json.Profundidade = $('#cad-item-profundidade').val();
        json.Peso = $('#cad-item-peso').val();
        json.PesoMaximoEmpilhamento = $('#cad-item-peso-maximo').val();
        json.CodigoDeBarras = $('#cad-item-codigo-barras').val();

        var parametrosAjax = { JsonTipoItemEstoque: JSON.stringify(json) };
        $.ajax({
            type: "POST",
            url: "/TipoItemEstoque/EditarTipoItemEstoque",
            data: parametrosAjax,
            success: function (result) {
                ModalLista.ItensDeEstoque.Carregar(() => { ModalLista.Filtrar(); });
                CadItem.Fechar();
            },
            error: function (req, status, error) {
                console.log("Erro.");
            }
        });
    }

    static Deletar = class Deletar {
        static Abrir(id) {
            $('#deletar-item-id').val(id);

            $('#modal-deletar-item').css('display', 'flex');
        }

        static Fechar() {
            $('#modal-deletar-item').css('display', 'none');
        }

        static Finalizar() {
            var parametrosAjax = { TipoItemEstoqueId: $('#deletar-item-id').val() };
            $.ajax({
                type: "POST",
                url: "/TipoItemEstoque/DeletarTipoItemEstoque",
                data: parametrosAjax,
                success: function (result) {
                    ModalLista.ItensDeEstoque.Carregar(() => { ModalLista.Filtrar(); });
                    CadItem.Deletar.Fechar();

                    $('#deletar-item-id').val('');
                },
                error: function (req, status, error) {
                    console.log("Erro.");
                }
            });
        }
    }

    static Estocar(id) {
        $.ajax({
            type: "POST",
            url: "/ControleDeEstoque/EstocarNovoItem",
            data: { TipoItemEstoqueId: id },
            success: async function (result) {
                if (result.NovoItemId != -1) {
                    await PackContainers();

                    view3D.UnpackAllItemsInRender();

                    var containerPackingResult = ContainerPackingResult.find(elem => elem.ContainerID == result.PrateleiraId);

                    if (containerPackingResult != null) {
                        view3D.ShowPackingView(containerPackingResult, result.NovoItemId);
                        view3D.PackAllItemsInRender();
                    }

                    ExibirRota(BalcaoAncoragem, containerPackingResult.Ancoragem, containerPackingResult.ContainerID);

                    ModalLista.Fechar();
                }
            },
            error: function (req, status, error) {
                console.log("Erro.");
            }
        });
    }

    static Retirar(id) {
        $.ajax({
            type: "POST",
            url: "/ControleDeEstoque/RetirarItem",
            data: { TipoItemEstoqueId: id },
            success: async function (result) {
                if (result.ItemId != -1) {
                    //await PackContainers();

                    view3D.UnpackAllItemsInRender();

                    var containerPackingResult = ContainerPackingResult.find(elem => elem.ContainerID == result.PrateleiraId);

                    if (containerPackingResult != null) {
                        view3D.ShowPackingView(containerPackingResult, result.ItemId);
                        view3D.PackAllItemsInRender();
                    }

                    ExibirRota(BalcaoAncoragem, containerPackingResult.Ancoragem, containerPackingResult.ContainerID);

                    ModalLista.Fechar();
                }
            },
            error: function (req, status, error) {
                console.log("Erro.");
            }
        });
    }
}