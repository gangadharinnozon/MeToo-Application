module CommentsHelper
#helper method to diplay all the  comments related to a particular post
  def find_comments(post)
	 return post.comments.find(:all)
 end
end
