class Asset
  attr_reader :url, :content_type

  def initialize(attrs)
    @url = attrs.fetch(:url)
    @content_type = attrs.fetch(:content_type)
  end
end
