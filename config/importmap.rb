# Pin npm packages by running ./bin/importmap

pin "application", preload: true
# pin "canvas-draw", to: "https://cdn.jsdelivr.net/npm/canvas-draw@1.0.0"
# pin "jspdf", to: "https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"
pin "jspdf", to: "lib/jspdf.umd.min.js"
pin "pdfjs", to: "lib/pdf.min.js"
pin "pdfworker", to: "lib/pdf.worker.min.js"
pin "jquery", to: "lib/jquery-3.7.1.min.js" , preload: true # @3.7.1

pin "select2", to: "lib/select2.min.js" # @4.1.0
# pin "select2-css", to: "select2.min.css"
pin "bootstrap", to: "lib/bootstrap.min.js" # @4.1.0

