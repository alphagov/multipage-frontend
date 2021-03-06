require 'rails_helper'

RSpec.describe MultipageController, type: :controller do
  describe "GET show" do
    let(:content_id) { SecureRandom.uuid }

    let(:details) do
      {
        "body" => "<p>Something about VAT</p>\n",
        "updated_at" => "2014-01-01T00:00:00.000+00:00",
      }
    end

    let(:content_item_attrs) do
      {
        "content_id" => content_id,
        "base_path" => "/vat-rates",
        "title" => "Vat rates",
        "description" => "VAT rates for goods and services",
        "public_updated_at" => "2014-05-14T13:00:06.000+00:00",
        "details" => details,
      }
    end

    context "for an existing content item" do
      before do
        content_store_has_item("/vat-rates", content_item_attrs)
      end

      it "renders the content item" do
        get :show, params: { slug: "vat-rates" }

        expect(response).to be_successful
      end
    end

    context "for an existing content item with parts" do
      before do
        details.merge!("parts" => [
          { "slug" => "information", "title" => "Information", "body" => "Body..." },
          { "slug" => "current-rates", "title" => "Current rates", "body" => "Body..." },
        ])
        content_store_has_item("/vat-rates", content_item_attrs)
      end

      it "responds successfully when the base content item is requested" do
        get :show, params: { slug: "vat-rates" }

        expect(response).to be_successful
        expect(assigns(:presenter).content).to be
        expect(assigns(:presenter).current_part).not_to be
      end

      it "responds successfully when a part is requested" do
        get :show, params: { slug: "vat-rates", part: "current-rates" }

        expect(response).to be_successful
        expect(assigns(:presenter).content).to be
        expect(assigns(:presenter).current_part.slug).to eq("current-rates")
      end

      it "redirects to the base path when an invalid part is requested" do
        get :show, params: { slug: "vat-rates", part: "current-rateses" }

        expect(response).to redirect_to("/vat-rates")
        expect(assigns(:presenter).content).to be
        expect(assigns(:presenter).current_part).not_to be
      end
    end

    context "for an invalid path" do
      before do
        content_store_does_not_have_item("/cat-rates")
      end

      it "responds with 404" do
        get :show, params: { slug: "cat-rates" }

        expect(response.status).to eq(404)
      end
    end

    context "format print" do
      before do
        content_store_has_item("/vat-rates", content_item_attrs)

        get :show, params: { slug: "vat-rates", variant: :print }
      end

      it "is successful" do
        expect(response).to be_successful
      end

      it "sets slimmer template header to print" do
        expect(response.header["X-Slimmer-Template"]).to eq("print")
      end

      it "renders the print page" do
        expect(response).to render_template("show")
        expect(response).to render_template("application.print")
      end
    end
  end
end
