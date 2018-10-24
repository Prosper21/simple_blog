class Article < ApplicationRecord
    after_save    :expire_contact_all_cache
    after_destroy :expire_contact_all_cache
    
    has_many :comments, dependent: :destroy
    validates :title, presence: true,
                      length: { minimum: 5 }
                      
    def self.all_cached
        Rails.cache.fetch('CArticle.all') { all.to_a }
    end
    
    def expire_contact_all_cache
        Rails.cache.delete('Article.all')
    end
    
end
