// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "./events"
import $ from 'jquery';
import * as bootstrap from "bootstrap"

$.ajaxSetup({
    beforeSend: (xhr) => {
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
    },
});