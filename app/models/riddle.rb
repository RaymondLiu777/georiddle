class Riddle < ApplicationRecord
  belongs_to :account

  VALID_VISIBILITY = ['public', 'private']

  validates :title, presence: true, length: { minimum: 3 }
  validates :description, presence: true, length: { minimum: 5 }
  validates :visibility, inclusion: { in: VALID_VISIBILITY }

  def isVisible?(account)
    visibility == 'public' or account_id == account.id
  end
end
