class MultipagePresenter
  extend Forwardable
  def_delegators :content,
    :current_part,
    :description,
    :next_part,
    :parts,
    :previous_part,
    :public_updated_at,
    :title,
    :updated_at,
    :links

  attr_accessor :content, :controller

  def initialize(content, controller)
    self.content = content
    self.controller = controller
  end

  def content_class_dasherized
    content.class.name.demodulize.underscore.dasherize
  end

  def breadcrumbs
    BreadcrumbsPresenter.new(breadcrumbs_data).present
  end

  def related_links
    ordered_breadcrumbs = BreadcrumbsPresenter.ordered_breadcrumbs(breadcrumbs_data)
    RelatedLinksPresenter.new(related_links_data, ordered_breadcrumbs).present
  end

  def format
    content.format
  end

private

  def breadcrumbs_data
    links[:parent] if links.present? && links.any?
  end

  def related_links_data
    links[:related] if links.present? && links.any?
  end
end
