require "rails_helper"

RSpec.describe "show multipage" do
  let(:content_item) {{
    "content_id": SecureRandom.uuid,
    "base_path": "/vat-rates",
    "title": "VAT rates",
    "description": "Something about VAT",
    "details": {
      "updated_at": "2015-10-14T12:00:10+01:00",
    },
    "format": "guide",
  }}
  before do
    content_store_has_item("/vat-rates", content_item)
  end

  scenario "requesting a path with an encoded slash" do
    expect {
      visit "/vat-rates%2F"
    }.to raise_error(ActionController::RoutingError)
  end

  scenario "requesting atom format for multipage#show" do
    expect {
      visit "/vat-rates.atom"
    }.to raise_error(ActionController::RoutingError)
  end

  scenario "requesting a valid path" do
    visit "/vat-rates"
    expect(page.status_code).to eq(200)
  end
end
