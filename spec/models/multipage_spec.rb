require "rails_helper"

RSpec.describe Multipage do
  describe "initialize" do
    let(:content_id) { SecureRandom.uuid }
    let(:details) do
      {
        "updated_at" => "2015-10-15T11:00:20+01:00",
        "parts" => [
          { "title" => "Part one", "slug" => "part-one", "body" => "A new beginning" },
          { "title" => "Part two", "slug" => "part-two", "body" => "The next bit" },
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
        "links" => { "parent" => ["cf6c7d60-f28b-4f09-9549-458779aee7c3"] },
      }
    end
    subject { described_class.new(attrs) }

    it "assigns current_part to nil by default" do
      expect(subject.current_part).to be nil
    end

    it "assigns each attribute" do
      expect(subject.content_id).to eq(attrs["content_id"])
      expect(subject.base_path).to eq(attrs["base_path"])
      expect(subject.title).to eq(attrs["title"])
      expect(subject.description).to eq(attrs["description"])
      expect(subject.public_updated_at).to eq("2015-10-15T11:00:20+01:00")
      expect(subject.links).to eq(parent: ["cf6c7d60-f28b-4f09-9549-458779aee7c3"])
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

    describe "previous_part" do
      it "is nil when the current part is nil" do
        expect(subject.previous_part).not_to be
      end

      context "when the current part is the first part" do
        subject { described_class.new(attrs, "part-one") }

        it "is nil" do
          expect(subject.previous_part).not_to be
        end
      end

      context "when the current part is not the first part" do
        subject { described_class.new(attrs, "part-two") }

        it "responds with the previous part in the parts array" do
          expect(subject.previous_part).to be(subject.parts.first)
        end
      end
    end


    describe "next_part" do
      it "is the second part when the current part is nil" do
        expect(subject.next_part).to be(subject.parts.second)
      end

      context "when only one part exists" do
        before do
          details["parts"].pop
        end

        it "is nil" do
          expect(subject.next_part).not_to be
        end
      end

      context "when the current part is the last part" do
        subject { described_class.new(attrs, "part-two") }

        it "is nil" do
          expect(subject.next_part).to be(nil)
        end
      end

      context "when the current part is not the last part" do
        subject { described_class.new(attrs, "part-one") }

        it "responds with the next part in the parts array" do
          expect(subject.next_part).to be(subject.parts.last)
        end
      end
    end
  end
end
