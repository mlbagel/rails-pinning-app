class Category<ActiveRecord::Base
  has_many :pins, dependent: :destroy 
end
