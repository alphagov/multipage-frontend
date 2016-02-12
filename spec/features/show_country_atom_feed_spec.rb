require "rails_helper"

describe "Viewing atom feed for albania" do
  let(:content_id) { SecureRandom.uuid }

  let(:details) do
    {
      "country" => { "name" => "Albania", "slug" => "albania" },
      "image" => {
        "url" => "https://assets.digital.cabinet-office.gov.uk/media/513a0efbed915d425e000002/120613_Albania_Travel_Advice_WEB_Ed2_jpeg.jpg",
        "content_type" => "image/jpeg"
      },
      "document" => {
        "url" => "https://assets.digital.cabinet-office.gov.uk/media/513a0efced915d4261000001/120613_Albania_Travel_Advice_Ed2_pdf.pdf",
        "content_type" => "application/pdf"
      },
      "summary" => "<p>Something about Albania</p>\n",
      "change_description" => "Something changed",
      "alert_status" => [],
      "email_signup_link" => "https://public.govdelivery.com/accounts/UKGOVUK/subscriber/topics?qsp=TRAVEL",
      "updated_at" => "2015-10-14T12:00:10+01:00",
      "reviewed_at" => "2015-10-14T12:00:10+01:00",
      "parts" => [
        {"title" => "Part one", "slug" => "part-one", "body" => "A new beginning"},
        {"title" => "Part two", "slug" => "part-two", "body" => "The next bit"},
      ]
    }
  end

  let(:content_item_attrs) do
    {
      "content_id" => content_id,
      "base_path" => "/foreign-travel-advice/albania",
      "title" => "Albania travel advice",
      "description" => "Latest travel advice for Albania including safety and security, entry requirements, travel warnings and health",
      "details" => details,
      "public_updated_at" => "2014-05-14T13:00:06.000+00:00",
      "format" => "travel_advice",
    }
  end

  before do
    content_store_has_item("/foreign-travel-advice/albania", content_item_attrs)
    visit("/foreign-travel-advice/albania.atom")
  end

  it "sets the alternative link correctly" do
    href = page.find("//feed/link[rel='alternate']")["href"]
    expect(href).to end_with("/foreign-travel-advice/albania")
  end

  it "sets the entry's id to the url concatenated with updated_at" do
    id = page.find("//feed/entry/id").text
    expect(id).to end_with("/foreign-travel-advice/albania#2014-05-14T13:00:06+00:00")
  end

  it "sets the entry's title correctly" do
    title = page.find("//feed/entry/title").text
    expect(title).to eq("Albania travel advice")
  end

  it "sets the entry's summary correctly" do
    summary = page.find("//feed/entry/summary").text
    expect(summary).to eq("Something changed")
  end
end
