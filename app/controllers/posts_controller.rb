
class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    if params[:sort_by_date] == 'ascending'
      @posts = Post.order(:created_at)
    elsif params[:sort_by_date] == 'descending'
      @posts = Post.order('created_at DESC')
    else
      @posts = Post.all
    end

    @form_url = "/posts"

    @links = [{:name => "Home", :path => root_path}, {:name => "Videos", :path => videos_path}]
  end

  # GET /posts/1
  # GET /posts/1.json
  def show

    def image_exists?(url)
      url = URI.parse(url)
      url.is_a?(URI::HTTP) && !url.host.nil?
      rescue URI::InvalidURIError
      false
    end

    @post = Post.find(params[:id])

    if image_exists?(@post[:photo_url])
      @image_exists = true
    end

    @links = [{:name => "Home", :path => root_path}, {:name => "Back to Posts", :path => posts_path}]

  end

  # GET /posts/new
  def new
    @post = Post.new

    @links = [{:name => "Home", :path => root_path}, {:name => "Back to Posts", :path => posts_path}]
  end

  # GET /posts/1/edit
  def edit

    @links = [{:name => "Home", :path => root_path}, {:name => "Back to Posts", :path => posts_path}]
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :author, :photo_url, :caption)
    end
end