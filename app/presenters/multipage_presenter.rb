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
    RelatedLinksPresenter.new.breadcrumbs
  end

  def related_links
    RelatedLinksPresenter.new.related_links
  end

  def format
    content.format
  end

  def publishing_request_id
    content.publishing_request_id
  end
end
