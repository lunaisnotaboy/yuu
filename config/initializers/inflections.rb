# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish.
ActiveSupport::Inflector.inflections(:en) do |inflect|
  inflect.acronym 'AMA'
  inflect.acronym 'ANN'
  inflect.acronym 'API'
  inflect.acronym 'DSL'
  inflect.acronym 'HTML'
  inflect.acronym 'MAL'
  inflect.acronym 'SSO'
  inflect.acronym 'STI'
  inflect.acronym 'XML'
  inflect.uncountable %w[
    anime
    anime_staff
    drama_staff
    manga
    manga_staff
    media
    media_staff
  ]
end
