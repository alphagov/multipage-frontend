require 'rails_helper'

RSpec.describe MultipartContentsController, type: :controller do
  describe "GET show" do
    context "for an existing content item" do
      before do
        content_store_has_item("/vat-rates")
      end

      it "renders the content item" do
        get :show, slug: "vat-rates"

        expect(response).to be_successful
      end
    end

    context "for an invalid path" do
      before do
        content_store_does_not_have_item("/cat-rates")
      end

      it "responds with 404" do
        get :show, slug: "cat-rates"

        expect(response.status).to eq(404)
      end
    end
  end
end
