require "rails_helper"

describe "Viewing travel advice for albania" do
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
      "public_updated_at" => "2014-05-14T13:00:06.000+00:00",
      "change_description" => "Something changed",
      "alert_status" => [],
      "email_signup_link" => "https://public.govdelivery.com/accounts/UKGOVUK/subscriber/topics?qsp=TRAVEL",
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
      "details" => details
    }
  end

  before do
    content_store_has_item("/foreign-travel-advice/albania", content_item_attrs)
    visit("/foreign-travel-advice/albania")
  end

  it "includes and API url for the content" do
    api_path = page.find("link[rel='alternate'][type='application/json']", visible: false)["href"]
    expect(api_path).to eq("/api/content/foreign-travel-advice/albania")
  end

  it "renders parts navigation" do
    within(".page-navigation") do
      expect(page).to have_content("Summary")
      expect(page).to have_link("Part one")
      expect(page).to have_link("Part two")
    end

    click_link("Part two")

    expect(page).to have_current_path("/foreign-travel-advice/albania/part-two")

    within(".content-block") do
      expect(page).to have_css("h1", text: "Part two")
      expect(page).to have_content("The next bit")
    end
  end

  it "renders the summary with assets" do
    within(".content-block") do
      expect(page).to have_css("h1", text: "Summary")
      expect(page).to have_content("Something about Albania")
      expect(page).to have_css("img[src='https://assets.digital.cabinet-office.gov.uk/media/513a0efbed915d425e000002/120613_Albania_Travel_Advice_WEB_Ed2_jpeg.jpg']")
      expect(page).to have_link("Download map (PDF)", href: "https://assets.digital.cabinet-office.gov.uk/media/513a0efced915d4261000001/120613_Albania_Travel_Advice_Ed2_pdf.pdf")
    end
  end

  it "renders the subscriptions info" do
    within(".subscriptions") do
      expect(page).to have_link("email", href: "https://public.govdelivery.com/accounts/UKGOVUK/subscriber/topics?qsp=TRAVEL")
      expect(page).to have_link("feed", href: "/foreign-travel-advice/albania.atom")
    end
  end
end