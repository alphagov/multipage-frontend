class Country
  attr_reader :slug, :name

  def initialize(attrs)
    return unless attrs
    @slug = attrs.fetch(:slug)
    @name = attrs.fetch(:name)
  end
end
