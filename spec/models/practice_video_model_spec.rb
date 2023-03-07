require 'rails_helper'

RSpec.describe PracticeVideo, type: :model do
  before(:each) do
    ActiveRecord::Base.connection.execute('DELETE FROM practice_videos')
    ActiveRecord::Base.connection.execute('DELETE FROM route_instances')
  end
  describe 'creates' do
    it 'creates a new practice video with a filename, video_name, video_create_date, description, and video_upload_date' do
      video = PracticeVideo.create(video_name: 'Test Video', video_create_date: '2023-08-01T01:23:45Z', description: 'Test video description')

      expect(video.video_name).to eq('Test Video')
      expect(video.video_create_date).to eq('2023-08-01T01:23:45Z')
      expect(video.description).to eq('Test video description')
    end
  end

  describe 'update' do
    it "updates an existing practice video's video_name and description" do
      video = PracticeVideo.create(video_name: 'Test Video', video_create_date: '2023-08-01T01:23:45Z', description: 'Test video description')
      video.update(video_name: 'Updated Test Video', description: 'Updated test video description')

      expect(video.video_name).to eq('Updated Test Video')
      expect(video.description).to eq('Updated test video description')
    end
  end

  describe 'destroy' do
    it 'deletes an existing practice video' do
      video = PracticeVideo.create(filename: 'video_file.mp4', video_name: 'Test Video', video_create_date: '2023-08-01T01:23:45Z', video_upload_date: '2023-08-01T01:23:45Z', description: 'Test video description', clip: fixture_file_upload('video_file.mp4', 'video/mp4'))
      video.destroy

      expect(PracticeVideo.find_by(id: video.id)).to be_nil
    end
  end

  describe 'show' do
    it 'returns the details of an existing practice video' do
      video = PracticeVideo.create(filename: 'video_file.mp4', video_name: 'Test Video', video_create_date: '2023-08-01T01:23:45Z', video_upload_date: '2023-08-01T01:23:45Z', description: 'Test video description', clip: fixture_file_upload('video_file.mp4', 'video/mp4'))
      shown_video = PracticeVideo.find(video.id)
      expect(shown_video.video_name).to eq('Test Video')
      expect(shown_video.video_create_date).to eq('2023-08-01T01:23:45Z')
      expect(shown_video.description).to eq('Test video description')
    end
  end

  describe 'index' do
    it 'lists all existing practice videos' do
      prev_count = PracticeVideo.all.count
      video1 = PracticeVideo.create(filename: 'test_video0.mp4', video_name: 'Test Video 0', video_create_date: '2023-08-01T01:23:45Z', description: 'Test video 1 description', clip: fixture_file_upload('test_Video_0.mp4', 'video/mp4'))
      video2 = PracticeVideo.create(filename: 'test_video1.mp4', video_name: 'Test Video 1', video_create_date: '2023-08-01T01:23:45Z', description: 'Test video 2 description', clip: fixture_file_upload('test_Video_1.mp4', 'video/mp4'))
      videos = PracticeVideo.all

      expect(videos.count).to eq(2 + prev_count)
      expect(videos).to include(video1)
      expect(videos).to include(video2)
    end
  end

  describe 'if create_practice_data is called' do
    before do
      CSV.foreach('db/seeds/players.csv', headers: true) do |row|
        Player.create!(row.to_hash)
      end
    end
    it 'creates practice data' do
      video = PracticeVideo.create(video_name: 'Test Video', video_create_date: '2023-08-01T01:23:45Z', description: 'Test video description')
      video.create_practice_data
      expect(RouteInstance.count).to eq(500)
    end
  end
end
