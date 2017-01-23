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

  attr_accessor :content, :navigation_helpers, :controller

  def initialize(content, navigation_helpers, controller)
    self.content = content
    self.navigation_helpers = navigation_helpers
    self.controller = controller
  end

  def content_class_dasherized
    content.class.name.demodulize.underscore.dasherize
  end

  def breadcrumbs
    navigation_helpers.breadcrumbs
  end

  def related_items
    navigation_helpers.related_items
  end

  def format
    content.format
  end

  def publishing_request_id
    content.publishing_request_id
  end
end
