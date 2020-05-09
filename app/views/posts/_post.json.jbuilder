json.extract! post, :id, :title, :author, :photo_url, :caption, :created_at, :updated_at
json.url post_url(post, format: :json)
