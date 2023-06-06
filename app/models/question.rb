class Question < ApplicationRecord
  belongs_to :project
  validates :title, presence: true
  validates :content, presence: true
  validates :status, presence: true
  validates :level, presence: true
  validates :project_id, presence: true
end
