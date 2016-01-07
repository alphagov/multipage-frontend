class MultipageContentsController < ApplicationController
  def show
    content_item_response = ContentStore.service.content_item(base_path)
    @content = model_class.new(content_item_response.to_hash) if content_item_response

    if @content.present?
      if params[:part]
        @content.current_part = current_part
        redirect_to base_path unless @content.current_part
      end
    else
      render_404
    end
  end

private

  def model_class
    controller_name.classify.constantize
  end

  def base_path
    "/#{params[:slug]}"
  end

  def current_part
    return unless part_slug = params[:part]
    return unless @content.parts && @content.parts.any?
    @content.parts.find{ |part| part.slug == part_slug }
  end
end
