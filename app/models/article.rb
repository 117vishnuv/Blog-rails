class Article < ApplicationRecord
    has_rich_text :text
    
    #make sure comments get dltd when srticle deletes 
    has_many :comments, dependent: :destroy 
   
    validates :title, presence: true,
    length: { minimum: 5 }
end
