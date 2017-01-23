require 'slimmer/test_helpers/govuk_components'
require 'slimmer/rspec'

module GovukComponent
  include Slimmer::TestHelpers::GovukComponents

  def expect_component(name, value, key = name)
    within shared_component_selector(name) do
      expect(JSON.parse(page.text).fetch(key)).to eq(value)
    end
  end

  def expect_title(value)
    expect_component("title", value)
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
