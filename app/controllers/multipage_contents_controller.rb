class MultipageContentsController < ApplicationController
  def show
    content_item_response = content_store.content_item(base_path)
    @content = model_class.new(content_item_response.to_hash, params[:part]) if content_item_response

    if @content.present?
      if params[:part]
        redirect_to base_path unless @content.has_part?(params[:part])
      end
    else
      error_404
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
