class Quip < ActiveRecord::Base
  belongs_to :user
  
  named_scope :descending, :order => 'id DESC'
  named_scope :random, :order => 'rand()'
  
  validates_presence_of :text
end
