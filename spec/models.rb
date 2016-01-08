class User < ActiveRecord::Base
  self.primary_key = :user_id
  
  has_many :albums, dependent: :destroy
  has_many :photos, through: :albums
  
  validates :name, presence: true
end

class Album < ActiveRecord::Base
  has_many :albums, dependent: :destroy
  has_many :photos, dependent: :destroy, foreign_key: :container_id
  has_many :tags, as: :taggable, dependent: :destroy
  belongs_to :user
  belongs_to :album
end

class Photo < ActiveRecord::Base
  belongs_to :user
  belongs_to :album
end

class Tag < ActiveRecord::Base
  belongs_to :user, polymorphic: true
end
