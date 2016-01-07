module ApplicationHelper
  def wrapper_css_class(content)
    content.class.name.demodulize.underscore.dasherize if content
  end
end
