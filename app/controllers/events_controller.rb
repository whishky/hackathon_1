class EventsController < ApplicationController

	before_action :correct_user,   only: [:edit, :update]

  def start
  end

  def index
  end

  def new
    if logged_in? == false
      flash[:danger] = "please login kr"
      redirect_to '/login'
    end
    @event = Event.new
  end

  def create
    @user = User.find(session[:user_id])
    @event = @user.events.build(event_params)
    if @event.save
      redirect_to '/events/show'
    else
      render 'new'
    end
  end
  
  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
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
  end

  def submit_solution
    @event = Event.find(params[:id])
    @gallary = @event.gallaries.new
  end

  def image_upload
    @user = User.find(session[:user_id])
    @event = Event.find(params[:event_id])
    @gallary = @event.gallaries.build(gallary_params)
    @gallary["user_id"] = @user["id"]
    if @gallary.save
      flash[:success] = "Image uploaded"
      redirect_to controller: 'events', action: 'event_info', id: @event.id
    else
      flash[:danger] = "error while uploading image"
      redirect_to controller: 'events', action: 'submit_solution', id: @event.id
    end
  end

  def search
    @events = Event.search(params[:search]).order("created_at DESC")
  end

  def show
    if params[:tag]
      @events = Event.joins(:taggings).where(taggings: {tag_id: Tag.find_by_name(params[:tag]).id})
    else
      @events = Event.all
    end
  end

  def event_info
    @event = Event.find(params[:id])
    @comments = @event.comments.paginate(page: params[:page])
    @gallaries = @event.gallaries
  end

  def find_current_time
    Time.now.strftime("%Y-%m-%d %H:%M")
  end

  def _present_events
    current_date_time = find_current_time
    @events = Event.all
    @events = @events.map{|k| k if k.start_date_time.to_s <= current_date_time.to_s && k.end_date_time.to_s >= current_date_time.to_s}.compact
  end

  def past_events
    current_date_time = find_current_time
    @events = Event.all
    @events = @events.map{|k| k if k.end_date_time.to_s < current_date_time.to_s}.compact
  end

  def future_events
    current_date_time = find_current_time
    @events = Event.all
    @events = @events.map{|k| k if k.start_date_time.to_s > current_date_time.to_s}.compact
  end

	# Confirms the correct user.
  def correct_user
    @event = Event.find(params[:id])
    unless @event.user_id == session[:user_id]
      current_date_time = Time.now.strftime("%Y-%m-%d %H:%M")
      if @event.start_date_time < current_date_time
      	flash[:danger] = "you can only edit the future events"
      	redirect_to(root_url)
      else
      	flash[:danger] = "you can only edit your events"
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

    def gallary_params
      params.require(:gallary).permit(:image, :user_id)
    end
end
