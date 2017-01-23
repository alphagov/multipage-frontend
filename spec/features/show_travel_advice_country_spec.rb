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
      "alert_status" => ["avoid_all_but_essential_travel_to_parts"],
      "email_signup_link" => "/foreign-travel-advice/albania/email-signup",
      "updated_at" => "2015-10-14T12:00:10+01:00",
      "reviewed_at" => "2015-10-14T12:00:10+01:00",
      "parts" => [
        { "title" => "Part one", "slug" => "part-one", "body" => "A new beginning" },
        { "title" => "Part two", "slug" => "part-two", "body" => "The next bit" },
      ],
      "publishing_request_id": "76435-3285345345-345435345-4354"
    }
  end

  let(:links) do
    {
      "parent" => [
        {
          "content_id" => "08d48cdd-6b50-43ff-a53b-beab47f4aab0",
          "base_path" => "/foreign-travel-advice",
          "title" => "Foreign travel advice",
          "links" => {
            "parent" => [
              {
                "content_id" => "b9849cd6-61a7-42dc-8124-362d2c7d48b0",
                "base_path" => "/browse/abroad/travel-abroad",
                "title" => "Travel abroad",
                "links" => {
                  "parent" => [
                    {
                      "content_id" => "86eb717a-fb40-42e7-83fa-d031a03880fb",
                      "base_path" => "/browse/abroad",
                      "title" => "Passports, travel and living abroad",
                      "links" => {}
                    }
                  ]
                }
              }
            ]
          },
        },
      ],
      "ordered_related_items" => [
        {
          "content_id" => "e4d06cb9-9e2e-4e82-b802-0aad013ae16c",
          "title" => "Driving abroad",
          "base_path" => "/driving-abroad",
          "links" => {
            "parent" => ["bbb8985a-5451-4e9d-a601-8c55853a096c"]
          }
        },
        {
          "content_id" => "95f9c380-30bc-44c7-86b4-e9c9ef0fc272",
          "title" => "Hand luggage restrictions at UK airports",
          "base_path" => "/hand-luggage-restrictions",
          "links" => {
            "parent" => ["b9849cd6-61a7-42dc-8124-362d2c7d48b0"]
          }
        },
        {
          "content_id" => "82248bb1-c4d6-41e0-9494-d98123475626",
          "title" => "Renew or replace your adult passport",
          "base_path" => "/renew-adult-passport",
          "links" => {
            "parent" => ["dd842862-e148-4fe3-b363-e57d6a2689aa"]
          }
        },
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
      "links" => links,
    }
  end

  before do
    content_store_has_item("/foreign-travel-advice/albania", content_item_attrs)
    visit("/foreign-travel-advice/albania")
  end

  it "includes an API url for the content" do
    api_path = page.find("link[rel='alternate'][type='application/json']", visible: false)["href"]
    expect(api_path).to eq("/api/content/foreign-travel-advice/albania")
  end

  it "renders breadcrumbs" do
    assert page.has_selector?(shared_component_selector('breadcrumbs'))
  end

  it "renders parts navigation" do
    within(".page-navigation") do
      expect(page).to have_content("Summary")
      expect(page).to have_link("Part one")
      expect(page).to have_link("Part two")
    end

    expect_title("Albania")
    expect_govspeak("<p>Something about Albania</p>\n")

    click_link("Part two")

    expect_title("Albania")
    expect(page).to have_current_path("/foreign-travel-advice/albania/part-two")
    expect(page).to have_css("h1", text: "Part two")
    expect_govspeak("The next bit")
  end

  it "renders the summary with assets" do
    expect(page).to have_css("h1", text: "Summary")
    expect_govspeak("<p>Something about Albania</p>\n")
    expect(page).to have_css("img[src='https://assets.digital.cabinet-office.gov.uk/media/513a0efbed915d425e000002/120613_Albania_Travel_Advice_WEB_Ed2_jpeg.jpg']")
    expect(page).to have_link("Download map (PDF)", href: "https://assets.digital.cabinet-office.gov.uk/media/513a0efced915d4261000001/120613_Albania_Travel_Advice_Ed2_pdf.pdf")
    expect(page).to have_link("Print entire guide", href: "/foreign-travel-advice/albania/print")
  end

  it "renders the subscriptions info" do
    within(".subscriptions") do
      expect(page).to have_link("email", href: "/foreign-travel-advice/albania/email-signup")
      expect(page).to have_link("feed", href: "/foreign-travel-advice/albania.atom")
    end
  end

  it "renders an alert status" do
    within(".help-notice") do
      expect(page).to have_content("advise against all but essential travel")
    end
  end

  it "renders related items" do
    assert page.has_selector?(shared_component_selector('related_items'))
  end

  it "renders HTML when an unspecific accepts header is requested (eg by IE8 and below)" do
    Capybara.current_session.driver.header('Accept', '*/*')
    visit("/foreign-travel-advice/albania")

    within(".page-navigation") do
      expect(page).to have_content("Summary")
      expect(page).to have_link("Part one")
      expect(page).to have_link("Part two")
    end
  end

  it "renders the publishing_request_id as a data attribute" do
    visit "/foreign-travel-advice/albania"

    expect(page).to have_css("meta[name='govuk:publishing-request-id'][content='76435-3285345345-345435345-4354']", visible: false)
  end
end
