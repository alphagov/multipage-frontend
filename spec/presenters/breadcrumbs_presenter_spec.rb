require "rails_helper"

RSpec.describe BreadcrumbsPresenter do
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

  subject { described_class.new(breadcrumbs) }

  describe "present" do
    it "reorders breadcrumbs by ancestor and presents in a component friedly format" do
      expect(subject.present).to eq(
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

    context "with nil data" do
      let(:breadcrumbs) { nil }

      it "returns an empty array" do
        expect(subject.present).to eq([{
            title: "Home",
            url: "/",
          }])
      end
    end

    context "with no data" do
      let(:breadcrumbs) { [] }

      it "returns an empty array" do
        expect(subject.present).to eq([{
            title: "Home",
            url: "/",
          }])
      end
    end

    context "with incomplete data" do
      let(:breadcrumbs) {
        [
          {
            content_id:  "08d48cdd-6b50-43ff-a53b-beab47f4aab0",
            base_path:  "/foreign-travel-advice",
            title: "Foreign travel advice",
            links: { },
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
      }

      it "doesn't attempt to sort" do
        expect(subject.present).to eq(
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
