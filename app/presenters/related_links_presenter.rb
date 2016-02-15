class RelatedLinksPresenter
  def initialize(related_links, ordered_breadcrumbs = [])
    @related_links = related_links
    @ordered_breadcrumbs = ordered_breadcrumbs
  end

  def present
    return [] if related_links.nil? || related_links.empty?

    assign_parents

    ordered_parents.map { |parent| component_format(parent) }
  end

private

  attr_reader :related_links, :ordered_breadcrumbs

  def parents
    related_links.select { |item| !item.key?(:links) || item[:links].empty? }
  end

  def children
    related_links - parents
  end

  def assign_parents
    parents.each { |parent| parent[:children] = [] }

    children.each do |child|
      parent = parents.find { |p| p[:content_id] == child[:links][:parent].first }
      parent[:children] << child
    end
  end

  def ordered_parents
    return parents if ordered_breadcrumbs.nil? || ordered_breadcrumbs.empty?

    ordered_content_ids = ordered_breadcrumbs.map { |bc| bc[:content_id] }
    parents.sort do |a, b|
      ordered_content_ids.index(b[:content_id]) <=> ordered_content_ids.index(a[:content_id])
    end
  end

  def component_format(content_item)
    hash = {
      title: content_item[:title],
      url: content_item[:base_path]
    }

    if content_item.key?(:children)
      hash[:items] = content_item[:children].map { |child| component_format(child) }
    end

    hash
  end
end
