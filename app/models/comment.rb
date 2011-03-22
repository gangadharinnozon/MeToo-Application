class Comment < ActiveRecord::Base
	#specifying the relation between post and comment model
   belongs_to :activity
   #sever side validation for comment should not be empty
  validates_presence_of :comment,:message=>"comment description should not be empty"
  #sever side validation for username should not be empty
  validates_presence_of :username,:message=>"username should not be empty"
  #sever side validation for username with comparing regurlar expression
   validates_format_of :username,:with=>/^[a-zA-Z]+[a-zA-Z0-9]*$/,:message=>"user name should start with characters and should not contain special characters"
   #specifying default scope for the post
  default_scope :order => 'created_at DESC'
end
