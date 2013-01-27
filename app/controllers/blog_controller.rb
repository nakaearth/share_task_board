class BlogController < ActionController::Metal
  include ActionController::Rendering
  include AbstractController::Helpers
  
  append_view_path BlogTemplate::Resolver.instance 
  def respond
    render :template => params[:page]
  end
end
