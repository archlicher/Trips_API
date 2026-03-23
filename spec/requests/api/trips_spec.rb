require 'rails_helper'

RSpec.describe "Trips API", type: :request do
  describe "GET /api/trips" do
    it "returns trips" do
      create_list(:trip, 5)
      get "/api/v1/trips"

      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /api/trips" do
    it "creates a trip" do
      post "/api/v1/trips", params: {
        trip: {
          name: "Test",
          image_url: "url",
          short_description: "short",
          long_description: "long",
          rating: 5
        }
      }

      expect(response).to have_http_status(:created)
    end
  end
end