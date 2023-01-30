require 'test_helper'

class PracticeVideosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @practice_video = practice_videos(:one)
  end

  test 'should get index' do
    get practice_videos_url
    assert_response :success
  end

  test 'should get new' do
    get new_practice_video_url
    assert_response :success
  end

  test 'should create practice_video' do
    assert_difference('PracticeVideo.count') do
      post practice_videos_url,
           params: { practice_video: { description: @practice_video.description, filename: @practice_video.filename,
                                       video_create_date: @practice_video.video_create_date, video_name: @practice_video.video_name, video_upload_date: @practice_video.video_upload_date } }
    end

    assert_redirected_to practice_video_url(PracticeVideo.last)
  end

  test 'should show practice_video' do
    get practice_video_url(@practice_video)
    assert_response :success
  end

  test 'should get edit' do
    get edit_practice_video_url(@practice_video)
    assert_response :success
  end

  test 'should update practice_video' do
    patch practice_video_url(@practice_video),
          params: { practice_video: { description: @practice_video.description, filename: @practice_video.filename,
                                      video_create_date: @practice_video.video_create_date, video_name: @practice_video.video_name, video_upload_date: @practice_video.video_upload_date } }
    assert_redirected_to practice_video_url(@practice_video)
  end

  test 'should destroy practice_video' do
    assert_difference('PracticeVideo.count', -1) do
      delete practice_video_url(@practice_video)
    end

    assert_redirected_to practice_videos_url
  end
end
