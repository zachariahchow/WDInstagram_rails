class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy]

  # GET /videos
  # GET /videos.json
  def index
    if params[:sort_by_date] == 'ascending'
      @videos = Video.order(:created_at)
    elsif params[:sort_by_date] == 'descending'
      @videos = Video.order('created_at DESC')
    else
      @videos = Video.all
    end

    @form_url = "/videos"

    @links = [{:name => "Home", :path => root_path}, {:name => "Posts", :path => posts_path}]
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
    def video_exists?(url)
      url = URI.parse(url)
      url.is_a?(URI::HTTP) && !url.host.nil?
      rescue URI::InvalidURIError
      false
    end

    @video = Video.find(params[:id])

    if video_exists?(@video[:video_url])
      @video_exists = true
      @youtube_id = @video[:video_url].split('=')[1]
    end

    @links = [{:name => "Home", :path => root_path}, {:name => "Back to Videos", :path => videos_path}]
  end

  # GET /videos/new
  def new
    @video = Video.new

    @links = [{:name => "Home", :path => root_path}, {:name => "Back to Videos", :path => videos_path}]
  end

  # GET /videos/1/edit
  def edit

    @links = [{:name => "Home", :path => root_path}, {:name => "Back to Videos", :path => videos_path}]
  end

  # POST /videos
  # POST /videos.json
  def create
    @video = Video.new(video_params)

    respond_to do |format|
      if @video.save
        format.html { redirect_to @video, notice: 'Video was successfully created.' }
        format.json { render :show, status: :created, location: @video }
      else
        format.html { render :new }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to @video, notice: 'Video was successfully updated.' }
        format.json { render :show, status: :ok, location: @video }
      else
        format.html { render :edit }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to videos_url, notice: 'Video was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def video_params
      params.require(:video).permit(:title, :author, :video_url, :caption)
    end
end