module MassDestroy
  extend ActiveSupport::Concern
  
  included do
    def mass_destroy(options = {})
      self.class.mass_destroy(id)
    end
  end
  
  class_methods do
    def mass_destroy(ids = nil)
      ids = ids ? Array(ids) : self.ids
      @associations = []
      
      # Recursively iterate through associations and collect all associations with record ids
      reflect_on_all_associations.each do |association|
        gather_association_ids(association, ids)
      end
      
      transaction do
        # Iterate backwards through associations and delete them
        @associations.reverse.each do |association, ids|
          association.klass.where(association.klass.primary_key => ids).delete_all
        end
      
        # Delete original record/recordss
        where(primary_key => ids).delete_all
      end
    end
    
    private
    
    # Recursive method to find all collections with dependent: :destroy or :destroy_all
    def gather_association_ids(association, belongs_to_ids)
      if association.options.include?(:dependent)
        ids = association.klass.where(association.foreign_key => belongs_to_ids).ids
        
        if ids.present?
          @associations << [association, ids]
        
          association.klass.reflect_on_all_associations.each do |association|
            gather_association_ids(association, ids)
          end
        end
      end
    end
  end
end

class ActiveRecord::Base
  include MassDestroy
end
