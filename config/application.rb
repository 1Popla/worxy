require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BetterFixly
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    config.i18n.default_locale = :pl
    config.i18n.available_locales = [:en, :pl]
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Don't generate system test files.
    config.generators.system_tests = nil
    config.x.app_data = {
      skills: ["Hydraulika", "Elektryka", "Stolarka", "Sprzątanie", "Ogrodnictwo", "Malowanie", "Przeprowadzki", "Zwalczanie Szkodników", "Dekarstwo", "Złota Rączka", "Klimatyzacja i Ogrzewanie", "Podłogi", "Murarstwo", "Ślusarstwo", "Naprawa AGD", "Mycie Okien", "Utrzymanie Basenów", "Bezpieczeństwo Domowe", "Wsparcie IT"],
      locations: ["Warszawa", "Kraków", "Łódź", "Wrocław", "Poznań", "Gdańsk", "Szczecin", "Bydgoszcz", "Lublin", "Katowice", "Cała Polska"],
      experience_levels: ["0-1 lat", "1-3 lat", "3-5 lat", "5-7 lat", "7-10 lat", "10+ lat"]
    }
  end
end
