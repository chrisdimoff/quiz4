class Auction < ApplicationRecord
  belongs_to :user
  has_many :bids, dependent: :destroy

  validates :user_id, presence: true
  validates :title, presence: true
  validates :details, presence: true
  validates :reserve_price, presence: true,
  numericality: {greater_than_or_equal_to: 1}
  # validate :end_date_valid

  # def end_date_valid
  #   if end_date.present? && end_date < Date.today
  #     errors.add(:end_date, "Can't be in the past.")
  #   end
  # end

  include AASM
  aasm whiny_transistions: false do
    state :draft, initial: true
    state :published
    state :reserve_met
    state :reserve_not_met
    state :canceled
    state :won

    event :publish do
      transitions from: :draft, to: :published
    end
    
    event :unpublish do
      transitions from: :published, to: :draft
    end

    event :reserve do
      transitions from: :published, to: :reserve_met
    end

    event :unreserve do
      transitions from: :published, to: :reserve_not_met
    end

    event :win do
      transitions from: :reserve_met, to: :won
    end

    event :cancel do
      transitions from: [:draft, :published, :reserve_not_met], to: :canceled
    end
  end

end
