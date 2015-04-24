json.array!(@snippets) do |snippet|
  json.extract! snippet, :id, :language, :plain_code, :highlighted_code
  json.url snippet_url(snippet, format: :json)
end
