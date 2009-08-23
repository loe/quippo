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
    
    perform_filters!
    
    append_hashtags!(hashtags)
  end
  
  private
  
  # Extract all hashtags from the text and return them in an array.
  def extract_hashtags!
    regex = /#\w+/
    hashtags  = self.text.scan(regex)
    self.text.gsub!(regex, '')
    hashtags
  end
  
  def append_hashtags!(hashtags)
    self.text = [self.text.strip, hashtags].flatten.join(' ')
  end
  
  def perform_filters!
    return if filter_quote_style!
    return if filter_parenthetical_retweet_style!
  end
  
  def filter_quote_style!
    # Match '"I am a quote" - Attribution'
    quote_type_match = /"(.+)"\s*-\s*(.+)/
    
    if match = text.match(quote_type_match)
      self.text        = match.captures[0]
      self.attribution = match.captures[1].strip
      true
    else
      false
    end
  end
  
  def filter_parenthetical_retweet_style!
    # Match 'OMG I am so awesome! (via @texel)'
    regex = /\(via (@\w+)\)/
    
    if match = text.match(regex)
      self.text.gsub!(regex, '')
      self.attribution = match.captures.first
      true
    else
      false
    end
  end
end
