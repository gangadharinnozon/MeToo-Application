class Activity < ActiveRecord::Base
#for specifying the relation between Activities and comments
  has_many :comments
	 #sever side validations for activity name
    validates_presence_of :activity_name,:message=>"Activity name should not be empty"
 
	 #sever side validation for username
     validates_presence_of :user_name,:message=>"Username should not be empty"
	  #sever side validation for post description
   validates_presence_of :activity_desc,:message=>"Activity Description should not be empty"
   #for specifying the relation between posts and tags
   acts_as_taggable
   #sever side validation for username with comparing regurlar expression
   validates_format_of :user_name,:with=>/^[a-zA-Z]+[a-zA-Z0-9\s]*$/,:message=>"user name should start with characters and should not contain special characters"
    validates_format_of:activity_name,:with=>/^[a-zA-Z]+[a-zA-Z0-9\s]*$/,:message=>"Activity name should start with characters and should not contain special characters"
  #specifying default scope for the post
  default_scope :order => 'created_at DESC'
end
