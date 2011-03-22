class ActivitiesController < ApplicationController
#method to create new activity Record
  auto_complete_for :activity, :activity_name
  def new
    @activity=Activity.new
  end
  #method to create a new activity Record with data
  def create
    @activity=Activity.new(params[:activity])
    @activity.tag_list=@activity.tag_list
    if @activity.save
      flash[:notice]="Activity created successfully"
      redirect_to :action=>:home
    else
      render :action=>"new"
    end
  end
  #method to display all the activities in the home page
  def home   
    @total = Activity.count()
    @activities_pages, @activities = paginate :activities,:per_page =>2
    if request.xml_http_request?
      render :partial => "activities_list", :layout => false
       
    end
  end
 
  #method to show a particular activity object details
  def show
    @activity=Activity.find(params[:id])
  end
  #method to update the user's like in the activity record in the database
  def like    
    activity=Activity.find(params[:id])    
    activity.update_attribute("like",activity.like+1)
    flash[:notice]="U Liked The Activity:#{activity.activity_name}"
    redirect_to :action=>"home"
  end
  #method to  show alll the activities related to a particular activity
  def show_tag_activities
    @tag=params[:id]   
    @activities=Activity.find(:all,:conditions=>["cached_tag_list = '#{@tag}'"])   
    render :action=>:showtags
  end

end
