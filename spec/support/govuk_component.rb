require 'slimmer/test_helpers/shared_templates'

module GovukComponent
  include Slimmer::TestHelpers::SharedTemplates

  def expect_component(name, key=name, value)
    within shared_component_selector(name) do
      expect(JSON.parse(page.text).fetch(key)).to eq(value)
    end
  end

  def expect_title(value)
    expect_component("title", value)
  end

  def expect_breadcrumbs(value)
    expect_component("breadcrumbs", value)
  end

  def expect_related_items(value)
    expect_component("related_items", "sections", value)
  end
end

RSpec.configure do |config|
  config.include GovukComponent, type: :feature
end
