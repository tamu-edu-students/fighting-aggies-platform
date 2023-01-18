Given('I am a data manager') do
  User.create({ name: 'Test DM', role: 'Data Manager', email: 'dataManager@gmail.com' })
end

Given('videos have been previously uploaded') do
  PracticeVideo.create!({ filename: 'test_Video_0', video_name: 'Test Video 0', video_create_date: '2023-01-01T01:23:45Z', video_upload_date: '2023-01-04T01:23:45Z', description: 'This is a description for test video 0' })
  PracticeVideo.create!({ filename: 'test_Video_1', video_name: 'Test Video 1', video_create_date: '2023-01-02T01:23:45Z', video_upload_date: '2023-01-05T01:23:45Z', description: 'This is a description for test video 1' })
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
