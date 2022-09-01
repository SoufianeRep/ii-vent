module ApplicationHelper
  def homepage?
    params[:controller] == 'pages' && params[:action] == 'home'
  end

  def signin_page?
    params[:controller] == 'devise/sessions' && params[:action] == 'new'
  end
end
