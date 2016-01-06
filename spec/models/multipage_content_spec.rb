require "rails_helper"

RSpec.describe MultipageContent do
  describe "initialize" do
    let(:content_id) { SecureRandom.uuid }
    let(:details) do
      {
        "parts" => [
          {"title" => "Part one", "slug" => "part-one", "body" => "A new beginning"},
          {"title" => "Part two", "slug" => "part-two", "body" => "The next bit"},
        ]
      }
    end
    let(:attrs) do
      {
        "base_path" => "/foo/bar",
        "title" => "A two part guide to foobar",
        "description" => "What follows is a brief description...",
        "content_id" => content_id,
        "public_updated_at" => "2015-10-15T11:00:20+01:00",
        "details" => details,
      }
    end
    subject { described_class.new(attrs) }

    it "assigns each attribute" do
      expect(subject.content_id).to eq(attrs["content_id"])
      expect(subject.base_path).to eq(attrs["base_path"])
      expect(subject.title).to eq(attrs["title"])
      expect(subject.description).to eq(attrs["description"])
      expect(subject.public_updated_at).to eq("2015-10-15T11:00:20+01:00")
    end

    it "assigns parts" do
      expect(subject.parts.size).to eq(2)

      expect(subject.parts.first.slug).to eq("part-one")
      expect(subject.parts.first.title).to eq("Part one")
      expect(subject.parts.first.body).to eq("A new beginning")

      expect(subject.parts.second.slug).to eq("part-two")
      expect(subject.parts.second.title).to eq("Part two")
      expect(subject.parts.second.body).to eq("The next bit")
    end
  end
end
