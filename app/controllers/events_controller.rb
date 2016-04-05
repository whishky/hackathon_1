class EventsController < ApplicationController
	def start

	end

	def new
	end

	def create
		@event = Event.new(event_params)
		#binding.pry
		if @event.save
			redirect_to '/events/show'

		else	
			render 'new'
		end
	end

	def show
		binding.pry
    		@events = Event.all
	end

	def event_info
		#binding.pry
		@event = Event.find(params[:id])
	end

	def _present_events
		@events = Event.all
	end

	def past_events
		@events = Event.all
	end

	def future_events
		@events = Event.all
	end

	def event_params
		params.require(:event).permit(:title, :description, :start_date, :end_date, :start_time, :end_time, :city, :address, :event_creater)
	end
end
