class PracticeVideosController < ApplicationController
  before_action :set_practice_video, only: %i[show edit update destroy]
  before_action :data_manager_authenticate

  # GET /practice_videos or /practice_videos.json
  def index
    @practice_videos = PracticeVideo.all
  end

  # GET /practice_videos/1 or /practice_videos/1.json
  def show; end

  # GET /practice_videos/new
  def new
    @practice_video = PracticeVideo.new
  end

  # GET /practice_videos/1/edit
  def edit; end

  # POST /practice_videos or /practice_videos.json
  def create
    @practice_video = PracticeVideo.new(practice_video_params)

    respond_to do |format|
      if @practice_video.save
        format.html do
          redirect_to practice_videos_url, notice: 'Practice video was successfully created.'
        end
        format.json { render :show, status: :created, location: @practice_video }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @practice_video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /practice_videos/1 or /practice_videos/1.json
  def update
    respond_to do |format|
      if @practice_video.update(practice_video_params)
        format.html do
          redirect_to practice_video_url(@practice_video), notice: 'Practice video was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @practice_video }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @practice_video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /practice_videos/1 or /practice_videos/1.json
  def destroy
    @practice_video.destroy

    respond_to do |format|
      format.html { redirect_to practice_videos_url, notice: 'Practice video was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_practice_video
    @practice_video = PracticeVideo.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def practice_video_params
    params.require(:practice_video).permit(:filename, :video_name, :video_create_date, :description, :clip,
                                           :video_upload_date, :length)
  end
end
