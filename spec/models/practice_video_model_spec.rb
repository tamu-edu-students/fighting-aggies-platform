require 'rails_helper'

RSpec.describe PracticeVideo, type: :model do
  describe 'creates' do
    it 'creates a new practice video with a filename, video_name, video_create_date, description, and video_upload_date' do
      video = PracticeVideo.create(filename: 'test_video.mp4', video_name: 'Test Video', video_create_date: '2023-08-01T01:23:45Z', video_upload_date: '2023-08-01T01:23:45Z', description: 'Test video description')

      expect(video.filename).to eq('test_video.mp4')
      expect(video.video_name).to eq('Test Video')
      expect(video.video_create_date).to eq('2023-08-01T01:23:45Z')
      expect(video.video_upload_date).to eq('2023-08-01T01:23:45Z')
      expect(video.description).to eq('Test video description')
    end
  end

  describe 'update' do
    it "updates an existing practice video's video_name and description" do
      video = PracticeVideo.create(filename: 'test_video.mp4', video_name: 'Test Video', video_create_date: '2023-08-01T01:23:45Z', video_upload_date: '2023-08-01T01:23:45Z', description: 'Test video description')
      video.update(video_name: 'Updated Test Video', description: 'Updated test video description')

      expect(video.video_name).to eq('Updated Test Video')
      expect(video.description).to eq('Updated test video description')
    end
  end

  describe 'destroy' do
    it 'deletes an existing practice video' do
      video = PracticeVideo.create(filename: 'test_video.mp4', video_name: 'Test Video', video_create_date: '2023-08-01T01:23:45Z', video_upload_date: '2023-08-01T01:23:45Z', description: 'Test video description')
      video.destroy

      expect(PracticeVideo.find_by(id: video.id)).to be_nil
    end
  end

  describe 'show' do
    it 'returns the details of an existing practice video' do
      video = PracticeVideo.create(filename: 'test_video.mp4', video_name: 'Test Video', video_create_date: '2023-08-01T01:23:45Z', video_upload_date: '2023-08-01T01:23:45Z', description: 'Test video description')
      shown_video = PracticeVideo.find(video.id)

      expect(shown_video.filename).to eq('test_video.mp4')
      expect(shown_video.video_name).to eq('Test Video')
      expect(shown_video.video_create_date).to eq('2023-08-01T01:23:45Z')
      expect(shown_video.video_upload_date).to eq('2023-08-01T01:23:45Z')
      expect(shown_video.description).to eq('Test video description')
    end
  end

  describe 'index' do
    it 'lists all existing practice videos' do
      prev_count = PracticeVideo.all.count
      video1 = PracticeVideo.create(filename: 'test_video1.mp4', video_name: 'Test Video 1 ', video_create_date: '2023-08-01T01:23:45Z', video_upload_date: '2023-08-01T01:23:45Z', description: 'Test video 1 description')
      video2 = PracticeVideo.create(filename: 'test_video2.mp4', video_name: 'Test Video 2', video_create_date: '2023-08-01T01:23:45Z', video_upload_date: '2023-08-01T01:23:45Z', description: 'Test video 2 description')
      videos = PracticeVideo.all

      expect(videos.count).to eq(2 + prev_count)
      expect(videos).to include(video1)
      expect(videos).to include(video2)
    end
  end
end
