require "rails_helper"

RSpec.describe TravelAdvicePresenter do
  describe "latest_update" do
    it "avoids duplication of 'Latest update' from change description" do
      json = GovukContentSchemaTestHelpers::Examples.new.get('travel_advice', 'full-country')
      @content_item = JSON.parse(json)

      [
        { original: "Latest update: Changes", presented: "Changes" },
        { original: "Latest update - changes", presented: "Changes" },
        { original: "Latest update changes", presented: "Changes" },
        { original: "Latest Update: Summary of changes. Next sentence", presented: "Summary of changes. Next sentence" },
      ].each do |i|
        expect(present_latest(i[:original])).to eq(i[:presented])
      end
    end
  end

  private

  def present_latest(latest)
    @content_item["details"]["change_description"] = latest
    navigation_helpers = GovukNavigationHelpers::NavigationHelper.new(@content_item)
    travel_advice = TravelAdvice.new(@content_item)
    presenter = TravelAdvicePresenter.new(travel_advice, navigation_helpers, nil)
    presenter.latest_update
  end
end
