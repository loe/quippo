module Transient
  module Session
    attr_accessor :search_prefs
    
    def search_prefs
      self[:search_prefs] ||= Hash.new
    end
  end
end