class ReservationsController < ApplicationController
  before_action :authenticate_user!, except: [:notify]

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

    redirect_to @reservation.property, notice: "Your request has been made..."
    # if @reservation
    #
    #   values = {
    #     business: 'ravi.bakhai-facilitator-1@gmail.com',
    #     cmd: '_xclick',
    #     upload: 1,
    #     notify_url: 'http://d65c9cb3.ngrok.io/notify',
    #     amount: @reservation.total,
    #     item_name: @reservation.property.listing_name,
    #     item_number: @reservation.id,
    #     quantity: '1',
    #     return: 'http://d65c9cb3.ngrok.io/your_places'
    #   }
    #
    #     redirect_to "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
    # else
		#     redirect_to @reservation.property, alert: "Ooops, something went wrong..."
    # end
  end

  def your_places
    @places = current_user.reservations
  end

  def your_reservations
    @properties = current_user.properties
  end
#   protect_from_forgery except: [:notify]
#   def notify
#     params.permit!
#     status = params[:payment_status]
#
#     reservation = Reservation.find(params[:item_number])
#
#     if status = "Completed"
#       reservation.update_attributes status: true
#     else
#       reservation.destroy
#     end
#
#     render nothing: true
#   end
#
# protect_from_forgery except: [:your_places]
#   def your_places
#     @places = current_user.reservations.where("status = ?", true)
#   end
#
#   def your_reservations
#     @properties = current_user.properties
#   end
#
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
