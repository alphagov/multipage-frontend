require "rails_helper"

RSpec.describe ApplicationHelper do
  describe "breadcrumbs" do
    it "constructs an array of breadcrumb hashes for use with the breadcrumb component" do
      data = [
        {
          content_id:  "08d48cdd-6b50-43ff-a53b-beab47f4aab0",
          base_path:  "/foreign-travel-advice",
          title:  "Foreign travel advice",
          links:  { parent:  ["b9849cd6-61a7-42dc-8124-362d2c7d48b0"] },
        },
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
      ]

      expect(helper.breadcrumbs(data)).to eq(
        [
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

    context "with nil data" do
      it "returns an empty array" do
        expect(breadcrumbs(nil)).to eq([])
      end
    end

    context "with no data" do
      it "returns an empty array" do
        expect(breadcrumbs([])).to eq([])
      end
    end

    context "with incomplete data" do
      it "doesn't attempt to sort incomplete data" do
        data = [
          {
            content_id:  "08d48cdd-6b50-43ff-a53b-beab47f4aab0",
            base_path:  "/foreign-travel-advice",
            title: "Foreign travel advice",
            links: { parent: [] },
          },
          {
            content_id: "86eb717a-fb40-42e7-83fa-d031a03880fb",
            base_path: "/browse/abroad",
            title:  "Passports, travel and living abroad",
          },
          {
            content_id: "b9849cd6-61a7-42dc-8124-362d2c7d48b0",
            base_path: "/browse/abroad/travel-abroad",
            title: "Travel abroad",
            links: { parent: ["86eb717a-fb40-42e7-83fa-d031a03880fb"] },
          },
        ]

        expect(helper.breadcrumbs(data)).to eq(
          [
            {
              title: "Passports, travel and living abroad",
              url: "/browse/abroad",
            },
            {
              title:  "Foreign travel advice",
              url:  "/foreign-travel-advice",
            },
            {
              title:  "Travel abroad",
              url:  "/browse/abroad/travel-abroad",
            },
          ]
        )
      end
    end
  end
end
