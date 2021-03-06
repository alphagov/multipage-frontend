class TravelAdvice < Multipage
  attr_reader :country, :image, :document, :summary, :change_description,
              :alert_status, :email_signup_link, :reviewed_at

  def initialize(attrs, part_slug = nil)
    super

    attrs = attrs.deep_symbolize_keys
    details = attrs.fetch(:details)
    @summary = details.fetch(:summary)
    @change_description = details.fetch(:change_description)
    @alert_status = details.fetch(:alert_status)
    @email_signup_link = details.fetch(:email_signup_link)
    @reviewed_at = details.fetch(:reviewed_at)

    assign_country(details)
    assign_assets(details)
  end

private

  def assign_country(details)
    country_attrs = details.fetch(:country)
    @country = Country.new(country_attrs)
  end

  def assign_assets(details)
    @image = Asset.new(details[:image]) if details.key?(:image)
    @document = Asset.new(details[:document]) if details.key?(:document)
  end
end
