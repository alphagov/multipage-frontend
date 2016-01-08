class Multipage

  attr_reader :current_part, :parts, :content_id, :base_path,
              :title, :description, :public_updated_at, :updated_at

  def initialize(attrs, part_slug=nil)
    attrs = attrs.deep_symbolize_keys
    @content_id = attrs.fetch(:content_id)
    @base_path = attrs.fetch(:base_path)
    @title = attrs.fetch(:title)
    @description = attrs.fetch(:description)

    if attrs[:public_updated_at]
      @public_updated_at = DateTime.parse(attrs[:public_updated_at])
    end

    details = attrs.fetch(:details)
    @updated_at = DateTime.parse(details.fetch(:updated_at))
    assign_parts(details)
    assign_current_part(part_slug)
  end

  def has_part?(slug)
    parts.find{ |p| p.slug == slug }.present?
  end

  def previous_part
    if parts.size > 1 && parts.first != current_part
      index = parts.index(current_part)
      parts[index - 1] if index
    end
  end

  def next_part
    if parts.size > 1 && parts.last != current_part
      index = parts.index(current_part) || 0
      parts[index + 1]
    end
  end

private

  def assign_parts(details)
    return unless details.key?(:parts)
    @parts = details[:parts].map { |part| Part.new(part) }
  end

  def assign_current_part(part_slug)
    return unless part_slug
    return unless parts.any?
    @current_part = parts.find{ |part| part.slug == part_slug }
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
