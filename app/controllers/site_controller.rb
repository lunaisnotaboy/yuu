# frozen_string_literal: true

class SiteController < ApplicationController
  def index
    render inertia: 'Home'
  end
end
