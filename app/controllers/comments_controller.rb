class CommentsController < ApplicationController
  #method new for creating new comment record/object
  def new
    @comment=Comment.new
    @activity = Activity.find(params[:id])
  end
  #method to create a  comment for a particular post
  def create
    @activity = Activity.find(params[:id])
    @comment=Comment.new(params[:comment])
    @comment.activity_id = @activity.id
    if @comment.save
      flash[:notice] ="comment created successfully!"
      redirect_to :controller =>"activities" ,:action =>"home"
    else
      render :action =>"new"
    end
  end
end
