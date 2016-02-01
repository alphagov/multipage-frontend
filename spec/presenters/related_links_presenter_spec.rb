require "rails_helper"

RSpec.describe RelatedLinksPresenter do
 let(:breadcrumbs) {
    [
      {
        content_id:  "86eb717a-fb40-42e7-83fa-d031a03880fb",
        base_path:  "/browse/abroad",
        title:  "Passports, travel and living abroad",
      },
      {
        content_id:  "b9849cd6-61a7-42dc-8124-362d2c7d48b0",
        base_path:  "/browse/abroad/travel-abroad",
        title:  "Travel abroad",
        links:  { parent:  ["86eb717a-fb40-42e7-83fa-d031a03880fb"] },
      },
      {
        content_id:  "08d48cdd-6b50-43ff-a53b-beab47f4aab0",
        base_path:  "/foreign-travel-advice",
        title:  "Foreign travel advice",
        links:  { parent:  ["b9849cd6-61a7-42dc-8124-362d2c7d48b0"] },
      },
    ]
  }

  let(:related_links) {
    [
      {
        content_id: "86eb717a-fb40-42e7-83fa-d031a03880fb",
        title: "Passports, travel and living abroad",
        base_path: "/browse/abroad",
      },
      {
        content_id: "82248bb1-c4d6-41e0-9494-d98123475626",
        title: "Renew or replace your adult passport",
        base_path: "/renew-adult-passport",
        links: {
          parent: ["86eb717a-fb40-42e7-83fa-d031a03880fb"]
        }
      },
      {
        content_id: "b9849cd6-61a7-42dc-8124-362d2c7d48b0",
        title: "Travel abroad",
        base_path: "/browse/abroad/travel-abroad",
      },
      {
        content_id: "95f9c380-30bc-44c7-86b4-e9c9ef0fc272",
        title: "Hand luggage restrictions at UK airports",
        base_path: "/hand-luggage-restrictions",
        links: {
          parent: ["b9849cd6-61a7-42dc-8124-362d2c7d48b0"]
        }
      },
      {
        content_id: "e4d06cb9-9e2e-4e82-b802-0aad013ae16c",
        title: "Driving abroad",
        base_path: "/driving-abroad",
        links: {
          parent: ["b9849cd6-61a7-42dc-8124-362d2c7d48b0"]
        }
      },
    ]
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
              title: "Hand luggage restrictions at UK airports",
              url: "/hand-luggage-restrictions",
            },
            {
              title: "Driving abroad",
              url: "/driving-abroad"
            }
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
                title: "Hand luggage restrictions at UK airports",
                url: "/hand-luggage-restrictions",
              },
              {
                title: "Driving abroad",
                url: "/driving-abroad"
              }
            ]
          },
        ])
      end
    end
  end
end
