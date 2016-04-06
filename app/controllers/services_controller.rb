class ServicesController < ApplicationController
  def index
    @services = Service.published.sort_by_sorting_position
  end

  def show

  end
end