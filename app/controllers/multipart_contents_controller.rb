class MultipartContentsController < ApplicationController
  def show
    @content = ContentStore.service.content_item("/#{params[:slug]}")
    render_404 unless @content.present?
  end
end
