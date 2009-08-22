class Quip < ActiveRecord::Base
  belongs_to :user
  
  validates_presence_of :text
end
