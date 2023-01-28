class PracticeVideo < ApplicationRecord
  has_one_attached :clip
  before_save :store_file_name
  validates :description,
            presence: true

  validates :video_name,
            presence: true,
            uniqueness: { case_sensitive: false }

  # validates :video_create_date, :video_upload_date,
  #           presence: true

  private
  def store_file_name
    self.filename = clip.filename
  end
end
