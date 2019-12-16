class Discussion < ApplicationRecord
  belongs_to :channel
  belongs_to :user
  #if a dissucsion is deleted so will the replies
  has_many :replies, dependent: :destroy
  #Ensure that submission can only be made of a discussion only if there is content and a title.
  validates :title, :content, presence: true
end
