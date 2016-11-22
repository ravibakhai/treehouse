class PagesController < ApplicationController
  def home
    @properties = Property.all
  end

  def search

    if params[:search].present? && params[:search].strip != ""
      session[:loc_search] = params[:search]
    else
      session[:loc_search] = ""
    end

    arrResult = Array.new

    if session[:loc_search] && session[:loc_search] != ""
      @properties_address = Property.where(active: true).near(session[:loc_search], 5, order: 'distance')
    else
      @properties_address = Property.where(active: true).all
    end

    @search = @properties_address.ransack(params[:q])
    @properties = @search.result

    @arrProperties = @properties.to_a

    if (params[:start_date] && params[:end_date])
  end
end
