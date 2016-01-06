class ApplicationController < ActionController::Base
  include Slimmer::Headers
  include Slimmer::Template

  slimmer_template "wrapper"

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

private

  def render_404
    render file: "#{Rails.root}/public/404.html", status: 404
  end
end
