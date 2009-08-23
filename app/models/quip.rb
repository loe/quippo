class Quip < ActiveRecord::Base
  belongs_to :user
  
  named_scope :descending, :order => 'id DESC'
  named_scope :random, :order => 'rand()'
  named_scope :text_search, lambda { |terms|
    predicates = []
    search_terms = []
    
    terms.each do |term|
      predicates << "(text LIKE ?)"
      search_terms << "%#{term}%"
    end
    
    conditions_array = [predicates.join(" OR "), search_terms].flatten
        
    {:conditions => conditions_array}
  }
  
  can_search do
    add_existing_scope :text_search
  end
  
  validates_presence_of :text
  
  def filter_attributions!
    hashtags = extract_hashtags!
    
    # Match '"I am a quote" - Attribution'
  end
  
  private
  
  # Extract all hashtags from the text and return them in an array.
  def extract_hashtags!
    regex = /#\w+(\s+|\b)/
    tags  = text.scan regex
    
    text.gsub!(regex, '')
    tags
  end
end
