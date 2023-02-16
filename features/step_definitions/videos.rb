require 'selenium-webdriver'

# Given('I am a data manager') do
#   User.create({ name: 'Test DM', role: 'Data Manager', email: 'dataManager@gmail.com' })
#   session[:data_manager] = true
# end

Given('videos have been previously uploaded') do
  PracticeVideo.create!({ filename: 'test_Video_0.mp4', video_name: 'Test Video 0',
                          video_create_date: '2023-01-01T01:23:45Z', video_upload_date: '2023-01-04T01:23:45Z', description: 'This is a description for test video 0' })
  PracticeVideo.create!({ filename: 'test_Video_1.mp4', video_name: 'Test Video 1',
                          video_create_date: '2023-01-02T01:23:45Z', video_upload_date: '2023-01-05T01:23:45Z', description: 'This is a description for test video 1' })
end

When('I go to the videos dashboard') do
  visit practice_videos_path
end

Then('I should see a list of previously uploaded videos') do
  expect(page).to have_content('Test Video 0')
  expect(page).to have_content('This is a description for test video 0')
  expect(page).to have_content('Test Video 1')
  expect(page).to have_content('This is a description for test video 1')
end

Then('I should be taken to the add video page') do
  expect(page).to have_current_path(new_practice_video_path)
end

Given('I am on the videos dashboard') do
  PracticeVideo.create!({ filename: 'test_Video_0', video_name: 'Test Video 0',
                          video_create_date: '2023-01-01T01:23:45Z', video_upload_date: '2023-01-04T01:23:45Z', description: 'This is a description for test video 0' })
  visit practice_videos_path
end

When('I click {string} on Test Video 0') do |button|
  click_link button
end

When('I click Test Video 0') do
  find('div#class-video-item', text: 'Test Video 0').click
end

Then('I should go to the edit video page for {string}') do |video_name|
  video = PracticeVideo.find_by(video_name:)
  expect(page).to have_current_path(edit_practice_video_path(video.id))
end

Given('I am editing {string}') do |video_name|
  PracticeVideo.create!({ filename: 'video_file', video_name:,
                          video_create_date: '2023-01-01T01:23:45Z', video_upload_date: '2023-01-04T01:23:45Z', description: 'This is a description for a test video' })
  video = PracticeVideo.find_by(video_name:)
  visit edit_practice_video_path(video.id)
end

When('I change {string} to {string}') do |field, value|
  fill_in field, with: value
end

When('I click the {string} button') do |button|
  sleep(2)
  click_button button
end

Then('I should be able to edit {string}') do |field|
  expect(page).to have_field(field, readonly: false)
end

Then('I should not be able to edit {string}') do |field|
  expect(page).to have_field(field, disabled: true)
end

Given('I am viewing {string}') do |video_name|
  PracticeVideo.create!({ filename: 'video_file', video_name:,
                          video_create_date: '2023-01-01T01:23:45Z', video_upload_date: '2023-01-04T01:23:45Z', description: 'This is a description for a test video' })
  video = PracticeVideo.find_by(video_name:)
  visit practice_video_path(video.id)
end

Then('I should be on the videos dashboard') do
  expect(page).to have_current_path(practice_videos_path)
end

Then('I should be taken to the view practice video page') do
  expect(page).to have_current_path(practice_video_path(1))
end

Then('I should be on the view {string} page') do |video_name|
  video = PracticeVideo.find_by(video_name:)
  expect(page).to have_current_path(practice_video_path(video.id))
end

When('I search {string}') do |search|
  fill_in 'search', with: search
end
