class News < ActiveRecord::Base

  validates_presence_of :title, :content

  scope :recent, -> { order(created_at: :asc) }

  def image_url
    content.match(/<img src="([^\"]+)?">/)[1] rescue ActionController::Base.helpers.asset_path('news.jpg')
  end
end
