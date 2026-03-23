class Api::TripsController < ApplicationController
  before_action :set_trip, only: [:show]

  def index
    trips = Trip.all
                .search(params[:search])
                .min_rating(params[:min_rating])
                .sorted(params[:sort])

    trips = trips.page(params[:page]).per(params[:per_page] || 10)

    render json: {
      data: TripSerializer.new(trips).serializable_hash[:data],
      meta: {
        current_page: trips.current_page,
        total_pages: trips.total_pages,
        total_count: trips.total_count
      }
    }
  end

  def show
    render json: TripDetailSerializer.new(@trip)
  end

  def create
    trip = Trip.new(trip_params)

    if trip.save
      render json: TripDetailSerializer.new(trip), status: :created
    else
      render json: { errors: trip.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_trip
    @trip = Trip.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Trip not found" }, status: :not_found
  end

  def trip_params
    params.require(:trip).permit(
      :name,
      :image_url,
      :short_description,
      :long_description,
      :rating
    )
  end
end