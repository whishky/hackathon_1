class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    #binding.pry
  	@event = Event.find(params["id"])
    @user = User.find(session[:user_id])
  	@comment = @event.comments.build(comment_params)
    @comment["user_id"] = @user["id"]
    if @comment.save
      flash[:success] = "Comment created!"
      binding.pry
      redirect_to controller: 'events', action: 'event_info', id: @event.id
    else
      render 'events/event_info'
    end
  end

  def destroy
    binding.pry
    @comment = Comment.find(params[:id])
    @event = Event.find(@comment.event_id)
    @comment.destroy
    flash[:success] = "Comment deleted"
    redirect_to controller: 'events', action: 'event_info', id: @event.id
  end

  def edit
  end

  def update 
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :user_id)
    end

end
