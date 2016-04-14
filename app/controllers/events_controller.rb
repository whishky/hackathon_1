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
    		@events = Event.all
	end

	def event_info
		#binding.pry
		@event = Event.find(params[:id])
	end

	def _present_events
		current_date_time = Time.now.strftime("%Y-%m-%d %H:%M")
		@events = Event.all
		@events = @events.map{|k| k if k.start_date_time.to_s <= current_date_time.to_s && k.end_date_time.to_s >= current_date_time.to_s}.compact!
	end

	def past_events
		current_date_time = Time.now.strftime("%Y-%m-%d %H:%M")
		@events = Event.all
		@events = @events.map{|k| k if k.end_date_time.to_s < current_date_time.to_s}.compact!

	end

	def future_events
		current_date_time = Time.now.strftime("%Y-%m-%d %H:%M")
		@events = Event.all
		@events = @events.map{|k| k if k.start_date_time.to_s > current_date_time.to_s}.compact!
	end

	def event_params
		params.require(:event).permit(:title, :description, :start_date_time, :end_date_time, :city, :address, :event_creater)
	end
end
