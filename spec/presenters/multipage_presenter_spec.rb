require "rails_helper"

RSpec.describe MultipagePresenter do

  let(:content_id) { SecureRandom.uuid }
  let(:details) do
    {
      "updated_at" => "2015-10-15T11:00:20+01:00",
    }
  end

  let(:breadcrumbs) {
    [
      {
        content_id:  "08d48cdd-6b50-43ff-a53b-beab47f4aab0",
        base_path:  "/foreign-travel-advice",
        title:  "Foreign travel advice",
        links:  { parent:  ["b9849cd6-61a7-42dc-8124-362d2c7d48b0"] },
      },
      {
        content_id:  "b9849cd6-61a7-42dc-8124-362d2c7d48b0",
        base_path:  "/browse/abroad/travel-abroad",
        title:  "Travel abroad",
        links:  { parent:  ["86eb717a-fb40-42e7-83fa-d031a03880fb"] },
      },
      {
        content_id:  "86eb717a-fb40-42e7-83fa-d031a03880fb",
        base_path:  "/browse/abroad",
        title:  "Passports, travel and living abroad",
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

  let(:attrs) do
    {
      "base_path" => "/foreign-travel-advice/spain",
      "title" => "Spain travel advice",
      "content_id" => content_id,
      "public_updated_at" => "2015-10-15T11:00:20+01:00",
      "description" => "Latest travel advice for Spain including safety and security, entry requirements, travel warnings and health",
      "details" => details,
      "links" => {
        "parent" => breadcrumbs,
        "related" => related_links,
      },
    }
  end

  let(:multipage) { Multipage.new(attrs) }

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
  end
end
