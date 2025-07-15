
  function actualizarTabla(factura_no) {
    $.ajax({
      url: "{% url 'obtener_detalles_por_factura' %}",
      data: { factura_no: factura_no },
      dataType: "json",
      success: function (response) {
        const tbody = $("#tabla-detalles tbody");
        tbody.empty(); // Limpia la tabla

        response.detalles.forEach(d => {
          tbody.append(`
            <tr>
              <td>${d.factura}</td>
              <td>${d.articulo}</td>
              <td>${d.cantidad}</td>
              <td><button class="btn btn-sm btn-warning">Editar</button></td>
            </tr>
          `);
        });
      }
    });
  }

  // Evento al enviar el formulario
  $("form").on("submit", function (e) {
    e.preventDefault();
    const form = $(this);
    const factura_no = $("#id_factura_no").val();

    $.ajax({
      url: form.attr("action") || window.location.href,
      type: "POST",
      data: form.serialize(),
      headers: { "X-CSRFToken": "{{ csrf_token }}" },
      success: function () {
        form[0].reset();
        $("#id_factura_no").val(factura_no);  // Mantiene la factura
        actualizarTabla(factura_no); // Actualiza la tabla
      }
    });
  });

  // Carga inicial si ya hay número de factura
  $(document).ready(function () {
    const facturaInicial = $("#id_factura_no").val();
    if (facturaInicial) {
      actualizarTabla(facturaInicial);
    }
  });
