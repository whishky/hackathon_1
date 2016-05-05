class EventsController < ApplicationController

	before_action :correct_user,   only: [:edit, :update]

	def start

	end

	def index
	end

	def new
		if logged_in? == false
			flash[:danger] = "Gaandu pehle login kr"
			redirect_to '/login'
		end
	end

	def create
		#binding.pry
		@user = User.find(session[:user_id])
		@event = @user.events.build(event_params)
		if @event.save
			redirect_to '/events/show'

		else	
			render 'new'
		end
	end

	def edit
		#binding.pry
  		@event = Event.find(params[:id])
	end

	def update
		#binding.pry
		@event = Event.find(params[:id])
		#@event = Event.new(event_params)
		#binding.pry

		flg = true
		params[:event].each do |key, value|
			if @event.update_attribute(key , value)
				flg &= true
			else
				flg &= false
			end
		end

		if flg
			redirect_to @event
		else
			redirect_to 'edit'
		end

		#if @event.save
		#	redirect_to '/events/show'

		#else	
		#	render 'new'
		#end
	end

	def search
		#binding.pry
		@events = Event.search(params[:search]).order("created_at DESC")
	end

	def show
    		#@events = Event.all
    	#binding.pry
    	if params[:tag]
    		#binding.pry
    		#tagging = Event.tagged_with(params[:tag])
    		#events = Event.all
    		@events = Event.joins(:taggings).where(taggings: {tag_id: Tag.find_by_name(params[:tag]).id})
			#@events = Event.tagged_with(params[:tag])
		else
			@events = Event.all
		end
	end

	def event_info
		#binding.pry
		@event = Event.find(params[:id])
		@comments = @event.comments.paginate(page: params[:page])
	end

	def _present_events
		#binding.pry
		current_date_time = Time.now.strftime("%Y-%m-%d %H:%M")
		@events = Event.all
		@events = @events.map{|k| k if k.start_date_time.to_s <= current_date_time.to_s && k.end_date_time.to_s >= current_date_time.to_s}.compact
	end

	def past_events
		current_date_time = Time.now.strftime("%Y-%m-%d %H:%M")
		@events = Event.all
		@events = @events.map{|k| k if k.end_date_time.to_s < current_date_time.to_s}.compact

	end

	def future_events
		current_date_time = Time.now.strftime("%Y-%m-%d %H:%M")
		@events = Event.all
		@events = @events.map{|k| k if k.start_date_time.to_s > current_date_time.to_s}.compact
	end

	# Confirms the correct user.
    def correct_user
      @event = Event.find(params[:id])
      unless @event.user_id == session[:user_id]
      	current_date_time = Time.now.strftime("%Y-%m-%d %H:%M")
      	binding.pry
      	if @event.start_date_time < current_date_time
      		flash[:danger] = "gandu u can only edit the future events"
      		redirect_to(root_url)
      	else
      		flash[:danger] = "gandu apne e event edit kr skta tu"
      		redirect_to(root_url) 
      	end
      end
    end

	private
		def event_params
			params.require(:event).permit(:title, :description, :start_date_time, :end_date_time, :city, :address, :event_creater, :all_tags)
		end

		def event_edit_params
			params.require(:event).permit(:title, :description, :start_date_time, :end_date_time, :city, :address, :event_creator)
		end
end
