module ApplicationHelper
  include RoutingConcern  
  FLASH_CLASSES = 'alert alert-dismissable alert-fullpage'


  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = I18n.t(:project_name)
    return base_title if page_title.nil? || page_title.empty?
    "#{base_title} | #{page_title}"
  end
  
  def flash_class(key)
    "#{FLASH_CLASSES} alert-#{normalize_flash_key(key)}"
  end

  #TODO: use https://github.com/bokmann/font-awesome-rails
  def flash_icon(key)
    case key
    when 'notice'
      "<i class='fa fa-check'></i>".html_safe
    when 'success'
      "<i class='fa fa-check'></i>".html_safe
    when 'alert'
      "<i class='fa fa-exclamation-triangle'></i>".html_safe
    when 'error'
      "<i class='fa fa-exclamation-triangle'></i>".html_safe
    when 'danger'
      "<i class='fa fa-exclamation-triangle'></i>".html_safe
    else
      "<i class='fa fa-exclamation-circle'></i>".html_safe
    end 
  end

  def new_experience
    @experience ||= Experience.new
  end

  def new_suggestion
    @suggestion ||= Suggestion.new
  end

private

  def normalize_flash_key(key)
    case key.downcase
    when 'notice' then 'info'
    when 'alert'  then 'danger'
    when 'error'  then 'danger'
    else
      key.downcase
    end
  end

end