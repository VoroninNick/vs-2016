class PagesController < ApplicationController
  def index
    @services = Service.published.sort_by_sorting_position
    @enable_tubular = !File.exists?("/media/data/pasha")
  end
end