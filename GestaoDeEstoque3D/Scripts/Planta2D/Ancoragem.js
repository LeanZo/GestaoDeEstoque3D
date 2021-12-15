class Ancoragem {
    static EstanteAncoragem = null;
    static DefinindoAncoragem = false;

    static Iniciar() {
        if (this.EstanteAncoragem != null) {
            //this.EstanteAncoragem.closePopup();
            planta.closePopup()

            $('#snackbar-ancoragem').css('visibility', 'visible');

            this.EstanteAncoragem.setStyle({ fillOpacity: 0.6 });

            this.DefinindoAncoragem = true;
        }
    }

    static DefinirPonto(latlng, callback = () => { }) {
        var estante = estantesAssociadas.find(i => i.PoligonoId == this.EstanteAncoragem.feature.properties.PoligonoId);

        var parametrosAjax = { EstanteId: estante.Id, Lat: latlng.lat, Lng: latlng.lng };
        $.ajax({
            type: "POST",
            url: "/Estante/DefinirPontoDeAncoragem",
            data: parametrosAjax,
            success: async function (result) {
                callback();
            },
            error: function (req, status, error) {
                console.log("Erro.");
            }
        });
    }

    static Finalizar() {
        $('#snackbar-ancoragem').css('visibility', 'hidden');

        if (this.EstanteAncoragem != null)
            this.EstanteAncoragem.setStyle({ fillOpacity: 0.2 });

        this.EstanteAncoragem = null;

        this.DefinindoAncoragem = false;
    }
}