module Quippo
  module Sanitizer
    def self.sanitize_terms(string, *terms)
      # We want to sanitize the following permutations:
      # "#term"
      # "@term"
      term_seed   = terms.map { |t| "#{t}\s*" }.join("|")
      expression  = /(@|#)(#{term_seed})/
            
      string.gsub(expression, "").strip
    end
  end
end