// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"

// To enable bootstrap tooltip on all pages
const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
const tooltipList = [...tooltipTriggerList];
tooltipList.map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))
