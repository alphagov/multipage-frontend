module ApplicationHelper
  def api_path
    "/api/content#{request.path}"
  end

  def breadcrumbs(data=breadcrumbs_data)
    return [] if data.nil?

    data = data.sort do |a, b|
      case
      when !b[:links] && a[:links]
        1
      when !a[:links] && b[:links]
        -1
      when b[:links].empty? && a[:links].key?(:parent)
        1
      when a[:links].empty? && b[:links].key?(:parent)
        -1
      when a[:links][:parent].first == b[:content_id]
        1
      when b[:links][:parent].first == a[:content_id]
        -1
      else
        0
      end
    end
    data.map { |d| { title: d[:title], url: d[:base_path] } }
  end

  def breadcrumbs_data
    @presenter.links[:parent] if @presenter.links.any?
  end
end
