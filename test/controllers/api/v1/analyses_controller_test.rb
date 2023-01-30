# frozen_string_literal: true

require 'test_helper'

module Api
  module V1
    class AnalysesControllerTest < ActionDispatch::IntegrationTest
      setup do
        @valid_video_path = Rails.root.join('storage', 'supplementary_video.mp4').to_s
      end

      # Read operation (GET) tests: index endpoint
      test 'should get index' do
        get api_v1_analyses_index_url
        assert_response :success
      end

      test 'index returns all analyses' do
        get api_v1_analyses_index_url
        analyses = @response.body
        assert_equal(analyses, Analysis.all.order(created_at: :desc).to_json,
                     "Analyses coming from index request don't match db's analyses")
      end

      # READ operation given ID (GET) tests: show endpoint
      test 'show no id' do
        get api_v1_analyses_show_url
        assert_response :bad_request
      end

      test 'show with invalid id: negative' do
        get api_v1_analyses_show_url, params: { id: -1 }
        assert_response :bad_request
      end

      test 'show with invalid id: not in database' do
        next_id = Analysis.maximum(:id).to_i.next # Queries the next id in DB (non-existent)
        get api_v1_analyses_show_url, params: { id: next_id }
        assert_response :bad_request
      end

      test 'show with valid id' do
        last_video = Video.create(@valid_video_path) # Add temporary video
        last_vision = Vision.create(last_video.id) # Add temporary vision
        last_analysis = Analysis.create(last_video.id)

        get api_v1_analyses_show_url, params: { id: last_analysis.id }
        assert_response :success
        assert_equal(last_analysis.to_json, @response.body, 'Requested analysis does not match with query ID')

        last_analysis.destroy
        last_vision.destroy # Remove temporary vision
        last_video.destroy # Remove temporary video
      end

      test 'show with valid id and raw_data flag' do
        last_video = Video.create(@valid_video_path) # Add temporary video
        last_vision = Vision.create(last_video.id) # Add temporary vision
        last_analysis = Analysis.create(last_video.id)

        get api_v1_analyses_show_url, params: { id: last_analysis.id, include_raw_data: true }
        assert_response :success

        response_body = JSON.parse(@response.body)
        response_body_parsed = JSON.parse(response_body['report'])
        response_body_keys = response_body_parsed.keys

        assert_equal(response_body_keys[0], 'frontend_report', 'Analysis does not include frontend report')
        assert_equal(response_body_keys[1], 'raw_data', 'Analysis does not include raw data as requested')
        assert_equal(JSON.parse(last_vision.report), response_body_parsed['raw_data'],
                     'Requested analysis does not include correct vision')
        assert_equal(JSON.parse(last_analysis.report), response_body_parsed['frontend_report'],
                     'Requested analysis does not match with query ID')

        last_analysis.destroy
        last_vision.destroy # Remove temporary vision
        last_video.destroy # Remove temporary video
      end

      # Create operation (POST) tests
      test 'create post no data' do
        post api_v1_analyses_create_url
        assert_response :bad_request
      end

      test 'create with inexistent video id' do
        post api_v1_analyses_create_url, params: { id: -1 }
        assert_response :bad_request
      end

      test 'create two analyses for same correct video id' do
        last_video = Video.create(@valid_video_path) # Add temporary video
        last_vision = Vision.create(last_video.id) # Add temporary vision

        post api_v1_analyses_create_url, params: { id: last_video.id }
        assert_response :created

        # Second analysis should fail if there's one already attached to video
        post api_v1_analyses_create_url, params: { id: last_video.id }
        assert_response :bad_request

        last_vision.destroy
        last_video.destroy # Remove temporary video
      end

      test 'create with correct video id after creating video' do
        last_video = Video.create(@valid_video_path) # Add temporary video
        last_vision = Vision.create(last_video.id) # Add temporary vision

        post api_v1_analyses_create_url, params: { id: last_video.id }
        assert_response :created

        last_analysis = Analysis.order('created_at').last
        assert_equal(last_analysis.to_json, @response.body, 'Created analysis does not match with latest db entry')

        last_vision.destroy # Remove temporary vision
        last_video.destroy # Remove temporary video
      end

      test 'create with correct video id after creating video with include_raw_data flag' do
        last_video = Video.create(@valid_video_path) # Add temporary video
        last_vision = Vision.create(last_video.id) # Add temporary vision

        post api_v1_analyses_create_url, params: { id: last_video.id, include_raw_data: true }
        assert_response :created

        last_analysis = Analysis.order('created_at').last

        response_body = JSON.parse(@response.body)
        response_body_parsed = JSON.parse(response_body['report'])
        response_body_keys = response_body_parsed.keys

        assert_equal(response_body_keys[0], 'frontend_report', 'Analysis does not include frontend report')
        assert_equal(response_body_keys[1], 'raw_data', 'Analysis does not include raw data as requested')
        assert_equal(JSON.parse(last_vision.report), response_body_parsed['raw_data'],
                     'Requested analysis does not include correct vision')
        assert_equal(JSON.parse(last_analysis.report), response_body_parsed['frontend_report'],
                     'Requested analysis does not match with query ID')

        last_analysis.destroy
        last_vision.destroy # Remove temporary vision
        last_video.destroy # Remove temporary video
      end

      # Destroy operation given ID (DELETE) tests
      test 'destroy no id' do
        delete api_v1_analyses_destroy_url
        assert_response :bad_request
      end

      test 'destroy with invalid id: negative' do
        delete api_v1_analyses_destroy_url, params: { id: -1 }
        assert_response :bad_request
      end

      test 'destroy with invalid id: not in database' do
        next_id = Analysis.maximum(:id).to_i.next # Queries the next id in DB (non-existent)
        delete api_v1_analyses_destroy_url, params: { id: next_id }
        assert_response :bad_request
      end

      test 'destroy with valid id' do
        last_video = Video.create(@valid_video_path) # Add temporary video
        last_vision = Vision.create(last_video.id) # Add temporary vision
        last_analysis = Analysis.create(last_video.id)

        delete api_v1_analyses_destroy_url, params: { id: last_analysis.id }
        assert_response :success

        new_last_analysis = Analysis.all.order(created_at: :desc).first
        unless assert_not_equal(last_analysis.to_json, new_last_analysis.to_json, 'Analysis was not deleted from DB')
          last_vision.destroy # Manually delete in case vision is not deleted by destroy
          last_analysis.destroy # Manually delete in case video is not deleted by destroy
        end
      end

      test 'destroying video also destroys analysis' do
        last_video = Video.create(@valid_video_path) # Add temporary video
        last_vision = Vision.create(last_video.id) # Add temporary vision
        last_analysis = Analysis.create(last_video.id)

        delete api_v1_videos_destroy_url, params: { id: last_video.id }
        assert_response :success

        new_last_analysis = Analysis.all.order(created_at: :desc).first
        unless assert_not_equal(last_analysis.to_json, new_last_analysis.to_json,
                                'Analysis was not deleted from DB when associated video was deleted')
          last_vision.destroy # Manually delete in case vision is not deleted by destroy
          last_analysis.destroy # Manually delete in case video is not deleted by destroy
        end
      end
    end
  end
end
