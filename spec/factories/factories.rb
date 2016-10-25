FactoryGirl.define do

  factory :category do
    name "rails"
  end

  sequence :slug do |n|
    "slug#{n}"
  end

  factory :pin do
    title "Rails 2222 Cheatsheet"
    url "http://rails-cheat.com"
    text "A great tool for beginning developers"
    slug
    category
    user
  end

  factory :board do
    name "My Pins!"
  end

  factory :user do
    sequence(:email) { |n| "coder#{n}@skillcrush.com" }
    first_name "Skillcrush"
    last_name "Coder"
    password "secret"

    factory :user_with_boards do
    after(:create) do |user|
      user.boards << FactoryGirl.create(:board)
      3.times do
        user.pinnings.create(pin: FactoryGirl.create(:pin), board: user.boards.first)
      end
    end
  end
end

  factory :user_with_followees do
    after(:create) do |user|
      3.times do
        Follower.create(user: FactoryGirl.create(:user), follower_id: user.id)
      end
    end
  end


  factory :pinning do
    user
    pin
    board
  end



end
