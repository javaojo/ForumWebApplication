class Reply < ApplicationRecord
  belongs_to :discussion
  belongs_to :user


  #Reply can only be submitted only if a reply is present
  validates :reply, presence: true
end
