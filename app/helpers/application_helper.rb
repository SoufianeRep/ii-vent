module ApplicationHelper
  def is_homepage?
    params[:controller] == 'pages' && params[:action] == 'home'
  end
end
