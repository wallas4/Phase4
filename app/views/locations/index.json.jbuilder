json.array!(@locations) do |location|
  json.extract! location, :id, :name, :tag
  json.url location_url(location, format: :json)
end
