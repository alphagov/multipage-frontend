class MultipageContent

  attr_reader :parts, :content_id, :base_path, :title, :description, :public_updated_at

  def initialize(attrs)
    attrs = attrs.deep_symbolize_keys
    @content_id = attrs.fetch(:content_id)
    @base_path = attrs.fetch(:base_path)
    @title = attrs.fetch(:title)
    @description = attrs.fetch(:description)
    @public_updated_at = attrs[:public_updated_at]
    details = attrs.fetch(:details)

    assign_parts(details)
  end

  def part?(slug)
    parts.find{ |p| p.slug == slug }.present?
  end

private

  def assign_parts(details)
    return unless details.key?(:parts)
    @parts = details[:parts].map { |part| Part.new(part) }
  end
end

class Part
  attr_reader :slug, :title, :body

  def initialize(attrs)
    @slug = attrs.fetch(:slug)
    @title = attrs.fetch(:title)
    @body = attrs.fetch(:body)
  end

  # TODO: Presenter method?
  def self.group_size(parts)
    size = parts.length.to_f/2
    if size < 2
      3
    else
      size.ceil
    end
  end
end
