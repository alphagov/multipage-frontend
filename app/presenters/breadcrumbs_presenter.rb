class BreadcrumbsPresenter
  def initialize(breadcrumbs)
    @breadcrumbs = breadcrumbs
  end

  def present
    return [home_breadcrumb] if breadcrumbs.nil?

    presented = ordered.map do |breadcrumb|
      {
        title: breadcrumb[:title],
        url: breadcrumb[:base_path]
      }
    end
    [home_breadcrumb] + presented
  end

  def self.ordered_breadcrumbs(breadcrumbs)
    self.new(breadcrumbs).ordered
  end

  def ordered
    return [] if breadcrumbs.nil?

    breadcrumbs.sort do |a, b|
      case
      when a[:links] && !b[:links]
        1
      when !a[:links] && b[:links]
        -1
      when a[:links].key?(:parent) && b[:links].empty?
        1
      when a[:links].empty? && b[:links].key?(:parent)
        -1
      when a[:links].empty? && b[:links].empty?
        0
      when a[:links][:parent].first == b[:content_id]
        1
      when a[:content_id] == b[:links][:parent].first
        -1
      else
        0
      end
    end
  end


private

  attr_reader :breadcrumbs

  def home_breadcrumb
    { title: "Home", url: "/" }
  end
end
