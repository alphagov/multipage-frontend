class ApplicationController < ActionController::Base
  include Slimmer::Headers
  include Slimmer::Template

  slimmer_template "wrapper"

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

private

  def content_store
    MultipageFrontend.content_store
  end

  def error_404; error 404; end

  def error(status_code, exception = nil)
    if exception and defined? Airbrake
      env["airbrake.error_id"] = notify_airbrake(exception)
    end
    render status: status_code, text: "#{status_code} error"
  end
end
