require 'slimmer/test_helpers/shared_templates'

module GovukComponent
  include Slimmer::TestHelpers::SharedTemplates

  def expect_component(name, key = name, value)
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

  def expect_analytics(key, value)
    within shared_component_selector("analytics_meta_tags"), visible: false do
      expect(JSON.parse(page.text(:all)).fetch(key)).to eq(value)
    end
  end

  def expect_govspeak(content)
    within shared_component_selector("govspeak") do
      expect(JSON.parse(page.text).fetch("content")).to eq(content)
    end
  end

  def expect_component_metadata_pair(label, value)
    within shared_component_selector("metadata") do
      # Flatten top level / "other" args, for consistent hash access
      component_args = JSON.parse(page.text).tap do |args|
        args.merge!(args.delete("other"))
      end
      expect(component_args.fetch(label)).to eq(value)
    end
  end
end

RSpec.configure do |config|
  config.include GovukComponent, type: :feature
end
