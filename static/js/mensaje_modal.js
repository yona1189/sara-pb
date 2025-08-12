/*Mostrar Modal*/
  document.addEventListener('htmx:afterSwap', (e) => {
    if (e.detail.target.id === "zona-modal") {
      const modal = new bootstrap.Modal(document.getElementById('mensajeModal'));
      modal.show();
    }
  });
  
  document.body.addEventListener('htmx:afterRequest', function (evt) {
    const xhr = evt.detail.xhr;
    try {
      const data = JSON.parse(xhr.responseText);

      if (data.modal) {
        // Inyectar el modal en el DOM
        document.getElementById("zona-modal").innerHTML = data.modal;

        // Esperar a que se cargue y lanzar el modal
        const modalElement = document.getElementById("miModal");  // ID de tu modal
        const modal = new bootstrap.Modal(modalElement);
        modal.show();
      }
    } catch (e) {
      console.error("No es un JSON válido:", e);
    }
  });
  /* Fin Mostrar Modal*/