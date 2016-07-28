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
    related_links.reject {|item| item.fetch(:links, {}).key?(:parent) }
  end

  def children
    related_links - parents
  end

  def assign_parents
    parents.each { |parent| parent[:children] = [] }

    children.each do |child|
      parent = parents.find do |p|
        parent = child[:links][:parent].first
        key = parent.is_a?(Hash) ? parent[:content_id] : parent
        p[:content_id] == key
      end
      parent[:children] << child if parent
    end

    parents.map {|parent| parent[:children].sort_by! {|child| child[:title]} }
  end

  def ordered_parents
    return parents if ordered_breadcrumbs.nil? || ordered_breadcrumbs.empty?

    ordered_content_ids = ordered_breadcrumbs.map { |bc| bc[:content_id] }
    parents.sort do |a, b|
      ordered_content_ids.index(b[:content_id]).to_i <=> ordered_content_ids.index(a[:content_id]).to_i
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
