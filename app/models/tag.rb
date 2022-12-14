class Tag < ApplicationRecord
  has_many :task_tags, dependent: :destroy
  has_many :tasks, through: :task_tags, dependent: :destroy

  validates :name, uniqueness: true, presence: true
end
