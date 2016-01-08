FactoryGirl.define do
  factory :user do
    sequence :name do |n|
      "user#{n}"
    end

    trait :with_albums do
      after(:build) do |user|
        3.times { user.albums << build(:album) }
      end
    end
    
    trait :with_albums_and_photos do
      after(:build) do |user|
        3.times do
          user.albums << build(:album, :with_photos)
        end
      end
    end
    
    trait :with_associations do
      after(:build) do |user|
        3.times do
          user.albums << build(:album, :with_photos)
        end
      end
    end
  end

  factory :album do
    sequence :title do |n|
      "album#{n}"
    end
    
    trait :with_photos do
      after(:build) do |album|
        3.times do
          album.photos << build(:photo)
          album.tags << build(:tag)
        end
      end
    end
  end
  
  factory :photo do
    sequence :url do |n|
      "example#{n}.com"
    end 
  end
  
  factory :tag do
    sequence :label do |n|
      "tag#{n}"
    end
  end
end
