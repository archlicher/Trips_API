class ApplicationController < ActionController::API
	# app/controllers/application_controller.rb
  rescue_from ActiveRecord::RecordNotFound do
    render json: { error: "Not Found" }, status: :not_found
  end
end
