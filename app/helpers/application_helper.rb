module ApplicationHelper
  def api_path
    "/api/content#{request.path}"
  end

  def wrapper_css_class(content)
    content.class.name.demodulize.underscore.dasherize if content
  end
end
