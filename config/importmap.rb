# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@editorjs/editorjs", to: "@editorjs--editorjs.js" # @2.30.5
pin "@editorjs/delimiter", to: "@editorjs--delimiter.js" # @1.4.2
pin "@editorjs/embed", to: "@editorjs--embed.js" # @2.7.4
pin "@editorjs/header", to: "@editorjs--header.js" # @2.8.7
pin "@editorjs/list", to: "@editorjs--list.js" # @1.10.0
pin "@editorjs/paragraph", to: "@editorjs--paragraph.js" # @2.11.6
pin "@editorjs/table", to: "@editorjs--table.js" # @2.4.1
pin "@editorjs/underline", to: "@editorjs--underline.js" # @1.1.0
pin "@editorjs/image", to: "@editorjs--image.js" # @2.9.3
pin "@editorjs/attaches", to: "@editorjs--attaches.js" # @1.3.0
pin "@editorjs/marker", to: "@editorjs--marker.js" # @1.4.0
pin "@editorjs/text-variant-tune", to: "@editorjs--text-variant-tune.js" # @1.0.3
pin "@editorjs/warning", to: "@editorjs--warning.js" # @1.4.0
