require "application_system_test_case"

class PracticeVideosTest < ApplicationSystemTestCase
  setup do
    @practice_video = practice_videos(:one)
  end

  test "visiting the index" do
    visit practice_videos_url
    assert_selector "h1", text: "Practice videos"
  end

  test "should create practice video" do
    visit practice_videos_url
    click_on "New practice video"

    fill_in "Description", with: @practice_video.description
    fill_in "Filename", with: @practice_video.filename
    fill_in "Video create date", with: @practice_video.video_create_date
    fill_in "Video name", with: @practice_video.video_name
    fill_in "Video upload date", with: @practice_video.video_upload_date
    click_on "Create Practice video"

    assert_text "Practice video was successfully created"
    click_on "Back"
  end

  test "should update Practice video" do
    visit practice_video_url(@practice_video)
    click_on "Edit this practice video", match: :first

    fill_in "Description", with: @practice_video.description
    fill_in "Filename", with: @practice_video.filename
    fill_in "Video create date", with: @practice_video.video_create_date
    fill_in "Video name", with: @practice_video.video_name
    fill_in "Video upload date", with: @practice_video.video_upload_date
    click_on "Update Practice video"

    assert_text "Practice video was successfully updated"
    click_on "Back"
  end

  test "should destroy Practice video" do
    visit practice_video_url(@practice_video)
    click_on "Destroy this practice video", match: :first

    assert_text "Practice video was successfully destroyed"
  end
end
