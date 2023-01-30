# frozen_string_literal: true

module Api
  module V1
    class VideosController < ApplicationController
      skip_before_action :verify_authenticity_token

      def index
        videos = Video.all.order(created_at: :desc)
        render json: videos
      end

      def create
        uploaded_file = video_params[:data]

        render status: 400, json: { errormessage: 'No video provided' }.to_json and return unless uploaded_file

        file_path = Rails.root.join('storage', 'uploads', uploaded_file.original_filename)

        file_dir = File.dirname(file_path)
        FileUtils.mkdir_p(file_dir) unless File.directory?(file_dir)

        begin
          File.open(file_path, 'wb') do |file|
            file.write(uploaded_file.read)
          end
        rescue StandardError
          render status: 500,
                 json: { errormessage: 'Not able to save video file due to server capacity.' }.to_json and return
        end

        begin
          video = Video.create!(file_path.to_s)
        rescue StandardError => e
          render status: 400, json: { errormessage: e }.to_json and return
        end

        render status: 201, json: video
      end

      def show
        render status: 400, json: { errormessage: 'No ID was provided' }.to_json and return unless video_params[:id]

        begin
          video ||= Video.find(video_params[:id])
        rescue StandardError
          render status: 400, json: { errormessage: 'Video with requested ID not found in DB' }.to_json and return
        end

        render status: 200, json: video and return
      end

      def destroy
        render status: 400, json: { errormessage: 'No ID was provided' }.to_json and return unless video_params[:id]

        begin
          video ||= Video.find(video_params[:id])
        rescue StandardError
          render status: 400, json: { errormessage: 'Video with requested ID not found in DB' }.to_json and return
        end

        video&.destroy
        render status: 200, json: video and return
      end

      private

      def video_params
        params.permit(:data, :id)
      end
    end
  end
end
