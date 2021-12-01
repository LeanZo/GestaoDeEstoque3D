﻿class ModalLista {
    static Objetos = [];

    static Abrir() {
        $('#modal-container').css('display', 'flex');
    }

    static Fechar() {
        $('#modal-container').css('display', 'none');

        $('#modal-pesquisa').val('');

        $('#modal-button-cadastrar-estante').css('display', 'none');
        $('#modal-button-cadastrar-item').css('display', 'none');

        $('#estantes-button').removeClass('acoes-crud-selecionado');
        $('#itens-de-estoque-button').removeClass('acoes-crud-selecionado');

        $('#modal-lista-corpo').empty();
    }

    static Filtrar() {
        var pesquisa = $('#modal-pesquisa').val().toLowerCase();

        $(".modal-item-container").css('display', 'none');

        if (pesquisa == '')
            $(".modal-item-container").css('display', 'flex');

        var objetosFiltrados = this.Objetos.filter(obj => obj.Id.toString().includes(pesquisa) || (obj.Nome != null && obj.Nome.toLowerCase().includes(pesquisa)));

        for (var i in objetosFiltrados) {
            $('.modal-item-container[data-id="' + objetosFiltrados[i].Id + '"]').css('display', 'flex');
        }
    }

    static Estantes = class Estantes {
        static Abrir() {
            ModalLista.Abrir();

            $('#modal-pesquisa').val('');
            ModalLista.Filtrar();

            $('#modal-button-cadastrar-estante').css('display', 'block');
            $('#modal-button-cadastrar-item').css('display', 'none');

            $('#estantes-button').addClass('acoes-crud-selecionado');
            $('#itens-de-estoque-button').removeClass('acoes-crud-selecionado');

            this.Carregar();
        }

        static Carregar() {
            $('#modal-lista-corpo').empty();

            $.ajax({
                type: "POST",
                url: "/Estante/RetornarEstantes",
                success: function (result) {
                    ModalLista.Objetos = result;

                    for (var i in result) {
                        result[i]

                        $('#modal-lista-corpo').append(`
                            <div class="modal-item-container" data-id="${result[i].Id}">
                                <div class="item-header">
                                    <span>Cód.: ${result[i].Id}</span>
                                </div>
                                <div class="item-corpo">
                                    <div>
                                        <span>
                                            Quantidade
                                            de Pratileiras
                                        </span>
                                        <span>${result[i].QtdPrateleiras}</span>
                                    </div>
                                    <hr>
                                    <div>
                                        <span>
                                            Largura
                                        </span>
                                        <span>${result[i].LarguraPrat}m</span>
                                    </div>
                                    <hr>
                                    <div>
                                        <span>
                                            Altura
                                        </span>
                                        <span>${result[i].AlturaPrat}m</span>
                                    </div>
                                    <hr>
                                    <div>
                                        <span>
                                            Profundidade
                                        </span>
                                        <span>${result[i].ProfundidadePrat}m</span>
                                    </div>
                                    <hr>
                                    <div>
                                        <span>
                                            Peso Máximo
                                        </span>
                                        <span>${result[i].PesoMaximoPrat}kg</span>
                                    </div>
                                </div>
                                <div class="item-footer">
                                    <div class="item-botao">
                                        <img src="/Content/Icones/layers.svg" width="24" height="24">
                                    </div>
                                    <div class="item-botao">
                                        <img src="/Content/Icones/edit.svg" width="24" height="24">
                                    </div>
                                    <div class="item-botao item-botao-deletar">
                                        <img src="/Content/Icones/trash.svg" width="24" height="24">
                                    </div>
                                </div>
                            </div>
                        `);
                    }
                },
                error: function (req, status, error) {
                    console.log("Erro.");
                }
            });
        }
    }

    static ItensDeEstoque = class ItensDeEstoque {
        static Abrir() {
            ModalLista.Abrir();

            $('#modal-pesquisa').val('');
            ModalLista.Filtrar();

            $('#modal-button-cadastrar-estante').css('display', 'none');
            $('#modal-button-cadastrar-item').css('display', 'block');

            $('#estantes-button').removeClass('acoes-crud-selecionado');
            $('#itens-de-estoque-button').addClass('acoes-crud-selecionado');

            this.Carregar();
        }

        static Carregar() {
            $('#modal-lista-corpo').empty();

            $.ajax({
                type: "POST",
                url: "/TipoItemEstoque/RetornarTiposItemEstoque",
                success: function (result) {
                    ModalLista.Objetos = result;

                    for (var i in result) {
                        result[i]

                        $('#modal-lista-corpo').append(`
                            <div class="modal-item-container" data-id="${result[i].Id}">
                                <div class="item-header">
                                    <span>${result[i].Nome}</span>
                                </div>
                                <div class="item-corpo">
                                    <div>
                                        <span>
                                            Código
                                        </span>
                                        <span>${result[i].Id}</span>
                                    </div>
                                    <hr>
                                    <div>
                                        <span>
                                            Largura
                                        </span>
                                        <span>${result[i].Largura}m</span>
                                    </div>
                                    <hr>
                                    <div>
                                        <span>
                                            Altura
                                        </span>
                                        <span>${result[i].Altura}m</span>
                                    </div>
                                    <hr>
                                    <div>
                                        <span>
                                            Profundidade
                                        </span>
                                        <span>${result[i].Profundidade}m</span>
                                    </div>
                                    <hr>
                                    <div>
                                        <span>
                                            Peso
                                        </span>
                                        <span>${result[i].Peso}kg</span>
                                    </div>
                                    <hr>
                                    <div>
                                        <span>
                                            Peso Máximo Empilhamento
                                        </span>
                                        <span>${result[i].PesoMaximoEmpilhamento}kg</span>
                                    </div>
                                </div>
                                <div class="item-footer">
                                    <div class="item-botao">
                                        <img src="/Content/Icones/plus.svg" width="24" height="24">
                                    </div>
                                    <div class="item-botao">
                                        <img src="/Content/Icones/minus.svg" width="24" height="24">
                                    </div>
                                    <div class="item-botao">
                                        <img src="/Content/Icones/edit.svg" width="24" height="24">
                                    </div>
                                    <div class="item-botao item-botao-deletar">
                                        <img src="/Content/Icones/trash.svg" width="24" height="24">
                                    </div>
                                </div>
                            </div>
                        `);
                    }
                },
                error: function (req, status, error) {
                    console.log("Erro.");
                }
            });
        }
    }

}