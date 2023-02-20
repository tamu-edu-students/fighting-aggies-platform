# require 'streamio-ffmpeg'
require 'csv'
class PracticeVideo < ApplicationRecord
  has_one_attached :clip
  before_save :store_metadata
  after_save :create_practice_data
  validates :description,
            presence: true

  validates :video_name,
            presence: true,
            uniqueness: { case_sensitive: false }

  validate :correct_video_type

  private

  def store_metadata
    self.filename = clip.filename
    self.video_upload_date = Time.now.utc.iso8601
  end

  def create_practice_data
    output_hashes = []
    CSV.foreach('db/seeds/route_instances.csv', headers: true) do |row|
      hash = row.to_hash
      hash['practice_id'] = filename
      hash['timestamp_start'] = int_to_time_string(hash['timestamp_start'].to_i)
      hash['timestamp_end'] = int_to_time_string(hash['timestamp_end'].to_i)
      output_hashes << hash
    end
    output_hashes.shuffle
    output_hashes[0..499].each_with_index do |item, _index|
      RouteInstance.create!(item)
    end
  end

  def int_to_time_string(milliseconds)
    seconds, milliseconds = milliseconds.divmod(1000)
    minutes, seconds = seconds.divmod(60)
    hours, minutes = minutes.divmod(60)
    format('%<hours>02d:%<minutes>02d:%<seconds>02d.%<milliseconds>03d', hours:, minutes:, seconds:, milliseconds:)
  end

  def correct_video_type
    return unless clip.attached? && !clip.content_type.in?(%w[video/mp4])

    errors.add(:clip, 'must be a mp4')
  end
end
