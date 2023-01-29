class PracticeVideo < ApplicationRecord
  has_one_attached :clip
  before_save :store_metadata
  validates :description,
            presence: true

  validates :video_name,
            presence: true,
            uniqueness: { case_sensitive: false }

  validate :correct_video_type

  # validates :video_create_date, :video_upload_date,
  #           presence: true

  private

  def store_metadata
    self.filename = clip.filename
    # self.video_create_date = clip.created_at
    self.video_upload_date = Time.now.utc.iso8601
  end

  def correct_video_type
    return unless clip.attached? && !clip.content_type.in?(%w[video/mp4])

    errors.add(:clip, 'must be a mp4')
  end
end
