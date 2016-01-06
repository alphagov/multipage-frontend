require 'rails_helper'

RSpec.describe TravelAdviceController do
  let(:content_id) { SecureRandom.uuid }

  let(:details) do
    {
      "summary" => "<p>Something about Albania</p>\n",
      "public_updated_at" => "2014-05-14T13:00:06.000+00:00",
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

  let(:content_item_attrs) do
    {
      "content_id" => content_id,
      "base_path" => "/foreign-travel-advice/albania",
      "title" => "Albania travel advice",
      "description" => "Latest travel advice for Albania including safety and security, entry requirements, travel warnings and health",
      "details" => details
    }
  end

  describe 'GET show' do
    before do
      content_store_has_item("/foreign-travel-advice/albania", content_item_attrs)
    end

    it "redirects to the base country path when an invalid part is requested" do
      get :show, country_slug: "albania", part: "tundra"

      expect(response).to redirect_to("/foreign-travel-advice/albania")
      expect(assigns(:content)).to be
      expect(assigns(:current_part)).not_to be
    end
  end
end
