class Book < ApplicationRecord
  has_one_attached :image
  belongs_to :user

  has_one_attached :profile_image

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path),filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  def get_profile_image(width, height)
        unless profile_image.attached?
          file_path = Rails.root.join('app/assets/images/no_image.jpg')
          profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
        end
        profile_image.variant(resize_to_limit: [width,height]).processed
  end

  validates :title, presence: true
  validates :body, presence: true
  validates :body, length: {maximum: 200}
end
