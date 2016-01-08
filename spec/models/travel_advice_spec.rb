require "rails_helper"

RSpec.describe TravelAdvice do
  describe "initialize" do
    let(:content_id) { SecureRandom.uuid }
    let(:details) do
      {
        "country" => {
          "name" => "Albania",
          "slug" => "albania",
        },
        "image" => {
          "url" => "https://assets.digital.cabinet-office.gov.uk/media/513a0efbed915d425e000002/120613_Albania_Travel_Advice_WEB_Ed2_jpeg.jpg",
          "content_type" => "image/jpeg"
        },
        "document" => {
          "url" => "",
          "content_type" => ""
        },
        "public_updated_at" => "2015-10-15T11:00:20+01:00",
        "summary" => "The summary",
        "change_description" => "Something changed",
        "alert_status" => [],
        "email_signup_link" => "https://public.govdelivery.com/accounts/UKGOVUK/subscriber/topics?qsp=TRAVEL",
        "reviewed_at" => "2015-10-14T12:00:10+01:00",
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
        "details" => details,
      }
    end
    subject { described_class.new(attrs) }

    it "inherits attributes assignment from MultipageContent" do
      expect(subject.content_id).to eq(content_id)
    end

    it "details attributes to be assigned" do
      expect(subject.summary).to eq("The summary")
      expect(subject.change_description).to eq("Something changed")
      expect(subject.alert_status).to eq([])
      expect(subject.email_signup_link).to eq("https://public.govdelivery.com/accounts/UKGOVUK/subscriber/topics?qsp=TRAVEL")
      expect(subject.reviewed_at).to eq("2015-10-14T12:00:10+01:00")
    end

    it "assigns the country" do
      expect(subject.country).to be
      expect(subject.country.name).to eq("Albania")
      expect(subject.country.slug).to eq("albania")
    end

    it "assigns an image" do
      expect(subject.image.url).to eq("https://assets.digital.cabinet-office.gov.uk/media/513a0efbed915d425e000002/120613_Albania_Travel_Advice_WEB_Ed2_jpeg.jpg")
      expect(subject.image.content_type).to eq("image/jpeg")
    end
    it "assigns a document" do
      expect(subject.document.url).to eq("")
      expect(subject.document.content_type).to eq("")
    end
  end
end
