require "memory_profiler"

class MultipageController < ApplicationController
  def show
    content_item_response = content_store.content_item(base_path)

    report = MemoryProfiler.report do
      content = model_class.new(content_item_response.to_hash, params[:part]) if content_item_response
    end
    report.pretty_print

    if content.present?

      @presenter = presenter_class.new(content, self)

      if params[:part] && !content.has_part?(params[:part])
        redirect_to base_path
        return
      end
    else
      error_404
      return
    end

    request.variant = :print if params[:variant].to_s == "print"

    respond_to do |format|
      format.html.none
      format.atom
      format.html.print do
        set_slimmer_headers template: "print"
        render layout: "application.print"
      end
    end
  end

private

  def model_class
    controller_name.classify.constantize
  end

  def presenter_class
    "#{controller_name.classify}Presenter".constantize
  end

  def base_path
    "/#{params[:slug]}"
  end

  def memory_profile_path
    profile_path = Rails.root.join("tmp", "profile")
    FileUtils.mkdir_p(profile_path) unless profile_path.exist?
    Rails.root.join("tmp", "profile", "#{Time.zone.now.to_i}#{request.fullpath.split("/").join("-")}.log")
  end
end
