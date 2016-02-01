module ApplicationHelper
  def api_path
    "/api/content#{request.path}"
  end
end
