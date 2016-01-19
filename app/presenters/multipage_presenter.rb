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
    :updated_at

  attr_accessor :content, :controller

  def initialize(content, controller)
    self.content = content
    self.controller = controller
  end

  def content_class_dasherized
    content.class.name.demodulize.underscore.dasherize
  end
end
