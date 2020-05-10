class HomeController < ApplicationController
  def index
    def video_exists?(url)
      url = URI.parse(url)
      url.is_a?(URI::HTTP) && !url.host.nil?
      rescue URI::InvalidURIError
      false
    end

    @videos = Video.order(:created_at).select {|video| video_exists?(video[:video_url])}

    @youtube_ids = @videos.map {|video|
      video[:video_url].split('=')[1]}

    @links = [{:name => "Posts", :path => posts_path}, {:name => "Videos", :path => videos_path}]
  end
end