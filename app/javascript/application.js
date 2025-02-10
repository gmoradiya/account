// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// import jsPDF from "jspdf";

import "jspdf";
import "pdfjs";
import 'pdfworker'


import "jquery"
import "select2"
import "bootstrap"

// import $ from 'jquery';
// window.$ = $;

document.addEventListener("DOMContentLoaded", function () {
  const toggleButton = document.querySelector(".nav-toggle");
  const navMenu = document.querySelector(".nav-menu");

  toggleButton.addEventListener("click", function () {
    navMenu.classList.toggle("active");
  });
});


document.addEventListener("DOMContentLoaded", function () {
  setTimeout(() => {
    document.querySelectorAll(".flash-message, .alert").forEach(el => {
      el.style.transition = "opacity 0.5s";
      el.style.opacity = "0";
      setTimeout(() => el.remove(), 500);
    });
  }, 3000);
});