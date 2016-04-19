require "rails_helper"

RSpec.describe RelatedLinksPresenter do
  let(:content_item) {
    json = GovukContentSchemaTestHelpers::Examples.new.get('travel_advice', 'full-country')
    content_item = JSON.parse(json)

    content_item.deep_symbolize_keys!
  }
  let(:breadcrumbs) {
    content_item[:links][:parent]
  }

  let(:related_links) {
    content_item[:links][:related]
  }

  subject { described_class.new(related_links, breadcrumbs) }

  describe "present" do
    it "groups child links to the parent section" do
      expect(subject.present).to eq([
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

    context "when related links is nil" do
      let(:breadcrumbs) { [] }
      let(:related_links) { nil }

      it "returns an empty array" do
        expect(subject.present).to eq([])
      end
    end

    context "when related links are empty" do
      let(:breadcrumbs) { [] }
      let(:related_links) { nil }

      it "returns an empty array" do
        expect(subject.present).to eq([])
      end
    end

    context "when parent links are incomplete" do
      let(:related_links) {
        content_item[:links][:related].reject { |i| i[:title] == "Travel abroad" }
      }
      it "excludes that parent" do
        expect(subject.present).to eq([
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

    context "with no breadcrumbs data to use for ordering" do
      let(:breadcrumbs) { [] }

      it "preserves the order in the original data" do
        expect(subject.present).to eq([
          {
            title: "Passports, travel and living abroad",
            url: "/browse/abroad",
            items: [
              {
                title: "Renew or replace your adult passport",
                url: "/renew-adult-passport"
              }
            ]
          },
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
        ])
      end
    end
  end
end
