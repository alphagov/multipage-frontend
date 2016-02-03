require "rails_helper"

RSpec.describe MultipagePresenter do

  let(:multipage) {
    json = GovukContentSchemaTestHelpers::Examples.new.get('travel_advice', 'full-country')
    content_item = JSON.parse(json)

    Multipage.new(content_item)
  }

  subject { described_class.new(multipage, nil) }

  describe "breadcrumbs" do
    it "constructs an array of breadcrumb hashes for use with the breadcrumb component" do
      expect(subject.breadcrumbs).to eq(
        [
          {
            title: "Home",
            url: "/",
          },
          {
            title: "Passports, travel and living abroad",
            url: "/browse/abroad",
          },
          {
            title:  "Travel abroad",
            url:  "/browse/abroad/travel-abroad",
          },
          {
            title:  "Foreign travel advice",
            url:  "/foreign-travel-advice",
          },
        ]
      )
    end
  end

  describe "related_links" do
    it "groups child links into ordered parent sections" do
      expect(subject.related_links).to eq([
        {
          title: "Travel abroad",
          url: "/browse/abroad/travel-abroad",
          items: [
           {
              title: "Driving abroad",
              url: "/driving-abroad"
            },
            {
              title: "Hand luggage restrictions at UK airports",
              url: "/hand-luggage-restrictions",
            },
          ]
        },
        {
          title: "Passports, travel and living abroad",
          url: "/browse/abroad",
          items: [
            {
              title: "Renew or replace your adult passport",
              url: "/renew-adult-passport"
            }
          ]
        }
      ])
    end
  end
end
