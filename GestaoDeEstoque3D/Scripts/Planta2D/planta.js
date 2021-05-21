var planta;
var camadas = [];
var layerControl;
var desenhandoPoligono = false;
var poligonoSelecionado;
var estantesAssociadas;

InicializarPlanta();

function InicializarPlanta() {
    planta = L.map('planta', {
        maxZoom: 30,
        minZoom: -30,
        crs: L.CRS.Simple,
        attributionControl: false,
        closePopupOnClick: false,
        preferCanvas: true,
        doubleClickZoom: false,
    }).setView([0, 0], 1);

    layerControl = L.control.layers(null, null, { position: 'topleft' }).addTo(planta);

    planta.pm.addControls({
        position: 'topleft',
        drawMarker: false,
        cutPolygon: false
    }); 

    planta.on('pm:drawend', function (e) {
        desenhandoPoligono = false;
    });

    planta.on('pm:create', function (event) {
        PrepararPoligonoParaSalvar(event.layer);
    });

    var imageUrl = '/Content/Imagens/exemplo-planta.png'
    var imageWidth = 1158;
    var imageHeight = 634;
    var fatorDivisao = 5;

    //SouthWest, NorthEast
    var imageBounds = [[-imageHeight / fatorDivisao, -imageWidth / fatorDivisao], [imageHeight / fatorDivisao, imageWidth / fatorDivisao]];

    var plantaArmazem = L.imageOverlay(imageUrl, imageBounds);
    layerControl.addOverlay(plantaArmazem, "Planta baixa");
    plantaArmazem.addTo(planta);

    CarregarCamadas();
}

function CarregarCamadas() {
    $.ajax({
        type: 'POST',
        url: 'Planta2D/CarregarCamadas',
        success: function (response) {
            estantesAssociadas = response.estantesAssociadas;

            var camadasGeojson = response.camadasGeojson;

            for (var camada of camadasGeojson) {
                camadas[camada.CamadaNome] = {
                    leafletLayer: null,
                    geojson: JSON.parse(camada.CamadaGeojson),
                    propriedades: {
                        CamadaId: camada.CamadaId,
                        CamadaNome: camada.CamadaNome,
                        CamadaGeojson: camada.CamadaGeojson,
                        CamadaCor: camada.CamadaCor
                    }
                };
            }

            AdicionarCamadas();
        },
        error: function () {
            console.log('Erro.');
        }
    });
}

function AdicionarCamadas() {
    for (var camadaNome in camadas) {
        var camada = camadas[camadaNome];

        var geojsonLayer = L.geoJson(camada.geojson, {
            onEachFeature: onEachFeature,
            style: function (feature) {
                return { color: camada.propriedades.CamadaCor };
            }
        });

        camadas[camada.propriedades.CamadaNome].leafletLayer = geojsonLayer;
        layerControl.addOverlay(geojsonLayer, camada.propriedades.CamadaNome);

        geojsonLayer.addTo(planta);
    }
}

function onEachFeature(feature, layer) {
    layer.on('click', function (e) {
        console.log(e.target.feature.properties);
    });

    layer.on('pm:update', function (event) {
        SalvarPoligono(event.layer, event.layer.feature.properties.CamadaId, event.layer.feature.properties.CamadaNome);
    });

    layer.on('pm:dragend', function (event) {
        SalvarPoligono(event.layer, event.layer.feature.properties.CamadaId, event.layer.feature.properties.CamadaNome);
    });

    layer.on('pm:remove', function (event) {
        DeletarPoligono(event.layer);
    });

    var estanteAssociada = estantesAssociadas.find(i => i.PoligonoId == layer.feature.properties.PoligonoId);
    
    if (estanteAssociada != null) {
        layer.bindTooltip('Cód.: ' + estanteAssociada.Id + '<br>Níveis: ' + estanteAssociada.QuantidadePrateleiras, {
            permanent: true,
            opacity: 1,
            className: 'label-planta',
            direction: 'center'
        });
    }

    //var tooltip = '';

    //if (layer.feature.properties.LAB_AREA != null)
    //    tooltip += "<br>Área: " + layer.feature.properties.LAB_AREA;

    //try {
    //    var propriedadesToolip = listaLayersJsonBruto[layer.feature.properties.LayerNome].props.propriedadesTooltip;
    //    for (var i in propriedadesToolip) {
    //        if (layer.feature.properties[propriedadesToolip[i]] != null)
    //            tooltip += "<br>" + propriedadesToolip[i] + ": " + layer.feature.properties[propriedadesToolip[i]];
    //    }
    //} catch (ex) {
    //    //fazer nada
    //}

    //tooltip = tooltip.replace('<br>', '');
    //if (tooltip != '')
    //    layer.bindTooltip(tooltip);
}

function PrepararPoligonoParaSalvar(poligono) {
    try {
        SalvarPoligono(poligono, poligono.feature.properties.CamadaId, poligono.feature.properties.CamadaNome);
    } catch (e) {
        var feature = poligono.feature = poligono.feature || {}; // Initialize feature
        feature.type = feature.type || "Feature"; // Initialize feature.type
        var props = feature.properties = feature.properties || {}; // Initialize feature.properties

        props.PoligonoId = "-1";

        AbrirModalNovoPoligono(poligono);
    }
}

function AbrirModalNovoPoligono(poligono) {
    var modal = document.getElementById("ModalNovoPoligono");
    var select_camada = $('#select-camada-novo-poligono');
    var btn = document.getElementById('btnNovoPoligono');

    select_camada.empty();

    for (i in camadas) {
        var camada = camadas[i];
        select_camada
            .append($("<option></option>")
                .attr("value", camada.propriedades.CamadaId)
                .text(camada.propriedades.CamadaNome));
    }

    btn.onclick = function () {
        modal.style.display = "none";
        var camadaId = $('#select-camada-novo-poligono').val();
        var camadaNome = $('#select-camada-novo-poligono option').filter(':selected').text();

        poligono.feature.properties.CamadaId = camadaId;
        poligono.feature.properties.CamadaNome = camadaNome;

        SalvarPoligono(poligono, camadaId, camadaNome);
    }

    modal.style.display = "flex";
}

function SalvarPoligono(poligono, camadaId, camadaNome) {
    camadas[camadaNome].leafletLayer.addLayer(poligono);
    poligono.options.onEachFeature = onEachFeature;
    onEachFeature(poligono.feature, poligono);

    try {
        poligono.bringToFront();
    } catch (e) {
        console.log('nao possui metodo layer.bringToFront()');
    }

    poligonoSelecionado = poligono;

    var parametrosAjax = { PoligonoId: poligono.feature.properties.PoligonoId, CamadaId: camadaId, Geojson: JSON.stringify(poligono.toGeoJSON()) };
    $.ajax({
        type: "POST",
        url: "/Planta2D/SalvarPoligono",
        data: parametrosAjax,
        success: function (result) {
            poligono.feature.properties.PoligonoId = result;
            poligono.setStyle({ color: camadas[camadaNome].propriedades.CamadaCor })
        },
        error: function (req, status, error) {
            console.log("Erro.");
        }
    });
}

function DeletarPoligono(poligono) {
    var parametrosAjax = { PoligonoId: poligono.feature.properties.PoligonoId };
    $.ajax({
        type: "POST",
        url: "/Planta2D/DeletarPoligono",
        data: parametrosAjax,
        success: function (result) {
            camadas[poligono.feature.properties.CamadaNome].leafletLayer.removeLayer(poligono)
        },
        error: function (req, status, error) {
            console.log("Erro.");
        }
    });
}