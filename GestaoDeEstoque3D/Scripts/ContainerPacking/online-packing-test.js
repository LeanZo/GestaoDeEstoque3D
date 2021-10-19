function AssociarUmTeste() {
	$.ajax({
		url: '/Inicio/AssociarUmTeste',
		type: 'POST',
		success: function (response) {
			console.log(response);
        }
	});
};