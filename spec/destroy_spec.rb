require 'spec_helper'

describe "MassDestroy" do
  
  describe '#mass_destroy' do
    let!(:users) { FactoryGirl.create_list(:user, 3, :with_associations) }
    
    it 'should destroy all in one query' do
      User.mass_destroy
      expect(User.count).to eq(0)
    end
    
    it 'should respect the scope of the destroy' do
      User.where(name: users.first.name).mass_destroy
      expect(User.count).to eq(2)
    end
    
    it 'should iterate through all dependent models and destroy them all' do
      User.mass_destroy
      expect(User.count).to eq(0)
      expect(Album.count).to eq(0)
      expect(Tag.count).to eq(0)
      expect(Photo.count).to eq(0)
    end
    
    it 'should delete polymorphic associations' do
      Album.mass_destroy
      expect(Tag.count).to eq(0)
    end
    
    it 'should work as an instance method' do
      expect { 
        User.first.mass_destroy
      }.to change{ Photo.count }.by(-9)
    end
  end
  
end
