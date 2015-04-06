class HomeController < ApplicationController
  before_action :hide_navs, only: [:preview]

  def index
    @featured = Challenge.featured
    @suggestions = Suggestion.all
    render user_page
  end

  def preview
    @class_name = params[:class_name]
    @object = @class_name == 'vote' ? 
              eval("#{session[:like][:likeable_type]}.find_by(id: #{session[:like][:likeable_id]})") :
              session[:object]
    @cancel_path = request.referer

    if @object.nil? || !(@class_name == 'vote' || @object.class.name.to_s.downcase == @class_name)
      flash[:danger] = "Sorry there is no preview to be shown. Please try again."
      redirect_to (@cancel_path || root_path)
    end
  end

private

  def user_page
    # return 'home_logged_in' if user_signed_in?
    'home_logged_out'
  end

end