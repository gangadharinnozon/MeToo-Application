# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
end
def pagination_links_full(paginator)
  page_param = :page
    url_param = params.dup    
    url_param.clear if url_param.has_key?(:set_filter)
    html = ''
    html << link_to_remote(("previous"), get_pagination_link_ajax_config(url_param, paginator.current.previous),
      {:href => url_for(:params => url_param.merge(:page => paginator.current.previous))}) + ' ' if paginator.current.previous 
  
    if paginator.current.next
      html << ' ' + link_to_remote(("next"),get_pagination_link_ajax_config(url_param, paginator.current.next),
        {:href => url_for(:params => url_param.merge(:page => paginator.current.next))})
    end
    return html
  end
  def get_pagination_link_ajax_config(url_param, target_id)
    {
      :update => 'content',
      :url => url_param.merge(:page => target_id),
      :complete => 'window.scrollTo(0,0)',
      :method => "get",
    }
  end
 
 
