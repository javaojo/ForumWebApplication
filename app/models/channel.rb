class Channel < ApplicationRecord
  has_many :discussion
  #This is a joined table, allowing for the database to go throught a user.
  has_many :users, through: :discussions

end
