ActiveRecord::Schema.define do
  self.verbose = false
  
  # This conveniently drops the table every time and recreates it (makes it easier for quick changes)
  [:photos, :albums, :tags, :users].each do |table|
    drop_table(table) if ActiveRecord::Base.connection.tables.include?(table.to_s)
  end

  create_table :users, id: false, force: :cascade do |t|
    t.primary_key :user_id
    t.string :name
    t.integer :group

    t.timestamps null: true
  end

  create_table :albums, force: :cascade do |t|
    t.integer :user_id, index: true, foreign_key: true
    t.references :album, index: true, foreign_key: true
    t.string :title

    t.timestamps null: true
  end

  create_table :photos, force: :cascade do |t|
    t.integer :container_id # testing foreign_key for album
    t.string :url

    t.timestamps null: true
  end
  
  create_table :tags, force: :cascade do |t|
    t.references :taggable, polymorphic: true
    t.string :label
    
    t.timestamps null: true
  end
end
