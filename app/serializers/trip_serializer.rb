class TripSerializer
  include FastJsonapi::ObjectSerializer
  
  attributes :name, :image_url, :short_description, :rating 
end
