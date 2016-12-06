require "rails_helper"

describe "Viewing the print page for travel advice Albania" do
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
      "email_signup_link" => "/foreign-travel-advice/albania/email-signup",
      "updated_at" => "2015-10-14T12:00:10+01:00",
      "reviewed_at" => "2015-10-14T12:00:10+01:00",
      "parts" => [
        { "title" => "Part one", "slug" => "part-one", "body" => "A new beginning" },
        { "title" => "Part two", "slug" => "part-two", "body" => "The next bit" },
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
    }
  end

  before do
    content_store_has_item("/foreign-travel-advice/albania", content_item_attrs)
    visit("/foreign-travel-advice/albania/print")
  end

  it "renders the print view including all travel advice parts" do
    expect(page.status_code).to eq(200)

    within "main[role=main]" do
      expect(page).to have_css("h1", text: "Albania travel advice")

      section_titles = page.all("article h1").map(&:text)
      expect(section_titles).to eq(["Part one", "Part two"])

      within "#summary" do
        expect(page).to have_css("h1", text: "Summary")
        expect_component_metadata_pair('Still current at', Date.today.strftime("%e %B %Y"))
        expect_component_metadata_pair('Updated', '14 October 2015')
        expect_component_metadata_pair('Latest update', '<p>Something changed</p>')

        expect(page).to have_content("Something about Albania")
      end

      within "#part-one" do
        expect(page).to have_css("h1", text: "Part one")
        expect(page).to have_content("A new beginning")
      end

      within "#part-two" do
        expect(page).to have_css("h1", text: "Part two")
        expect(page).to have_content("The next bit")
      end
    end
  end
end
