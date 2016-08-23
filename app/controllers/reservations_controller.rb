class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def create
    @reservation = current_user.reservations.create(reservation_params)

    redirect_to @reservation.property, notice: "Your sublet request has been made..."
  end

  private
    def reservation_params
      params.require(:reservation).permit(:start_date, :end_date, :price, :total, :property_id)
    end
end
