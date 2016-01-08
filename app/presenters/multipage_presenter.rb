class MultipagePresenter
  extend Forwardable
  def_delegators :content,
    :title,
    :description,
    :parts,
    :public_updated_at,
    :updated_at

  attr_accessor :content, :controller

  def initialize(content, controller)
    self.content = content
    self.controller = controller
  end
end
