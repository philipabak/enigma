class CaseStudy < ActiveRecord::Base

  mount_uploader :image, CaseStudyImageUploader

  validates_presence_of :company, :branch, :body, :image, :feedback, :feedbacker_name, :job
end
