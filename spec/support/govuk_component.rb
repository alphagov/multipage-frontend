require 'slimmer/test_helpers/shared_templates'

module GovukComponent
  include Slimmer::TestHelpers::SharedTemplates

  def expect_component_title(title)
    within shared_component_selector("title") do
      expect(title).to eq(JSON.parse(page.text).fetch("title"))
    end
  end

  def expect_component_breadcrumbs(breadcrumbs)
    within shared_component_selector("breadcrumbs") do
      expect(breadcrumbs).to eq(JSON.parse(page.text).fetch("breadcrumbs"))
    end
  end
end

RSpec.configure do |config|
  config.include GovukComponent, type: :feature
end
