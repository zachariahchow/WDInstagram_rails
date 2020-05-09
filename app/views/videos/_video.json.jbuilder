json.extract! video, :id, :title, :author, :video_url, :caption, :created_at, :updated_at
json.url video_url(video, format: :json)
