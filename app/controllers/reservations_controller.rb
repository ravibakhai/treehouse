class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def preload
		property = Property.find(params[:property_id])
		today = Date.today
		reservations = property.reservations.where("start_date >= ? OR end_date >= ?", today, today)

		render json: reservations
	end

	def preview
		start_date = Date.parse(params[:start_date])
		end_date = Date.parse(params[:end_date])

		output = {
			conflict: is_conflict(start_date, end_date)
		}

		render json: output
	end

	def create
		@reservation = current_user.reservations.create(reservation_params)

    if @reservation

      values = {
        business: '',
        cmd: '_xclick'
        upload: 1,
        notify_url: '',
        amount: @reservation.total,
        item_name: @reservation.property.listing_name,
        item_number: @reservation.id,
        quantity: '1'
        return: ''
      }

        redirect_to ""
    else
		    redirect_to @reservation.property, alert: "Ooops, something went wrong..."
    end
  end

  def your_places
    @places = current_user.reservations
  end

  def your_reservations
    @properties = current_user.properties
  end

	private
		def is_conflict(start_date, end_date)
			property = Property.find(params[:property_id])

			check = property.reservations.where("? < start_date AND end_date < ?", start_date, end_date)
			check.size > 0? true : false
		end

		def reservation_params
			params.require(:reservation).permit(:start_date, :end_date, :price, :total, :property_id)
		end
end
