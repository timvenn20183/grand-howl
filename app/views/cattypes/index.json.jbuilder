json.array!(@cattypes) do |cattype|
  json.extract! cattype, :name, :category_id
  json.url cattype_url(cattype, format: :json)
end
