class MultipageContentsController < ApplicationController
  def show
    content_item_response = content_store.content_item(base_path)
    @content = model_class.new(content_item_response.to_hash, params[:part]) if content_item_response

    if @content.present?
      if params[:part] && !@content.has_part?(params[:part])
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

  def base_path
    "/#{params[:slug]}"
  end
end
