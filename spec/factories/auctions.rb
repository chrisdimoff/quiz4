FactoryGirl.define do
  factory :auction do
    association :user, factory: :user
    title "MyString"
    details "MyText"
    end_date "MyString"
    reserve_price 1.5
  end
end
