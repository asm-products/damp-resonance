json.array!(@ads) do |ad|
  json.extract! ad, :id
  json.url ad_url(ad, format: :json)
end
