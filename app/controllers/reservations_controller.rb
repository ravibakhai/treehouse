class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def preload
  property = Property.find(params[:property_id])
  today = Date.today
  reservations = property.reservations.where("start_date >= ? OR end_date >= ?", today, today)

  render json: reservations
  end

  def create
  @reservation = current_user.reservations.create(reservation_params)

  redirect_to @reservation.property, notice: "Your sublet request has been made..."
  end

  private
    def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :price, :total, :property_id)
    end
  end
