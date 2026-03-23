class TripDetailSerializer
  include FastJsonapi::ObjectSerializer
  
  attributes :name, :image_url, :short_description, :long_description, :rating 
end
