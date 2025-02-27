// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import "jspdf";
import "pdfjs";
import 'pdfworker'
import "jquery"
import "select2"
import "bootstrap"

document.addEventListener("DOMContentLoaded", function () {
  setTimeout(() => {
    document.querySelectorAll(".flash-message, .alert").forEach(el => {
      el.style.transition = "opacity 0.5s";
      el.style.opacity = "0";
      setTimeout(() => el, 500);
    });
  }, 3000);
});


document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('a[data-method="delete"]').forEach(link => {
    link.addEventListener('click', (event) => {
      event.preventDefault();
      const confirmed = confirm('Are you sure?');
      if (confirmed) {
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = link.href;

        const input = document.createElement('input');
        input.type = 'hidden';
        input.name = '_method';
        input.value = 'delete';
        form.appendChild(input);

        const csrfToken = document.querySelector('meta[name="csrf-token"]').content;
        const csrfInput = document.createElement('input');
        csrfInput.type = 'hidden';
        csrfInput.name = 'authenticity_token';
        csrfInput.value = csrfToken;
        form.appendChild(csrfInput);

        document.body.appendChild(form);
        form.submit();
      }
    });
  });
});
