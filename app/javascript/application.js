// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// Import additional JavaScript files as needed
import "./message-scroll.js"

// Initialize Rails features
import { start as startRailsUjs } from "@rails/ujs"
import { start as startActiveStorage } from "@rails/activestorage"
import * as channels from "channels"

startRailsUjs()
startActiveStorage()
channels.start()

