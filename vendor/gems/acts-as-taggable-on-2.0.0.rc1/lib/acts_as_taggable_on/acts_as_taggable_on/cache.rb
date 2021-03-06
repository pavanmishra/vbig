module ActsAsTaggableOn::Taggable
  module Cache
    def self.included(base)
      # Skip adding caching capabilities if no cache columns exist
      return unless base.tag_types.any? { |context| base.column_names.include?("cached_#{context.to_s.singularize}_list") }

      base.send :include, ActsAsTaggableOn::Taggable::Cache::InstanceMethods
      base.extend ActsAsTaggableOn::Taggable::Cache::ClassMethods
      
      base.class_eval do
        before_save :save_cached_tag_list        
      end
      
      base.intialize_acts_as_taggable_on_cache
    end
    
    module ClassMethods
      def intialize_acts_as_taggable_on_cache      
        tag_types.map(&:to_s).each do |tag_type|
          class_eval %(
            def self.caching_#{tag_type.singularize}_list?
              caching_tag_list_on?("#{tag_type}")
            end        
          )
        end        
      end
      
      def acts_as_taggable_on(*args)
        super(*args)
        intialize_acts_as_taggable_on_cache
      end
      
      def caching_tag_list_on?(context)
        column_names.include?("cached_#{context.to_s.singularize}_list")
      end
    end
    
    module InstanceMethods
      def tag_list_cache_set_on(context)
        variable_name = "@#{context.to_s.singularize}_list"
        !instance_variable_get(variable_name).nil?
      end
      
      def save_cached_tag_list
        tag_types.map(&:to_s).each do |tag_type|
          if self.class.send("caching_#{tag_type.singularize}_list?")
            if tag_list_cache_set_on(tag_type)
              list = tag_list_cache_on(tag_type.singularize).to_a.flatten.compact.join(', ')
              self["cached_#{tag_type.singularize}_list"] = list
            end
          end
        end
      end
    end
  end
end