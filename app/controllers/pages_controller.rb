class PagesController < ApplicationController
  def home
    @properties = Property.limit(3)
  end

  def search

    if params[:search].present? && params[:search].strip != ""
      session[:loc_search] = params[:search]
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

    if (params[:start_date] && params[:end_date] && !params[:start_date].empty? & !params[:end_date].empty?)

      start_date = Date.parse(params[:start_date])
      end_date = Date.parse(params[:end_date])

      @properties.each do |property|

        not_available = property.reservations.where(
          "(? <= start_date AND start_date <= ?)
          OR (? <= end_date AND end_date <= ?)
          OR (start_date < ? AND ? < end_date)",
          start_date, end_date,
          start_date, end_date,
          start_date, end_date
        ).limit(1)

        if not_available.length > 0
          @arrProperties.delete(property)
        end
      end
  end
end
end
