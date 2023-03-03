# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "stimulus-dropdown" # @2.0.0
pin "hotkeys-js" # @3.8.9
pin "stimulus-use" # @0.50.0
pin_all_from "app/javascript/lib", under: "lib"
pin "stimulus-flatpickr" # @3.0.0
pin "flatpickr" # @4.6.13
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.0.1
pin "stimulus-rails-nested-form", to: "https://ga.jspm.io/npm:stimulus-rails-nested-form@4.0.0/dist/stimulus-rails-nested-form.es.js"
pin "stimulus" # @3.0.1
