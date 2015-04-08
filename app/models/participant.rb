class Participant < ActiveRecord::Base
    has_and_belongs_to_many :participants
    has_many :roster
    has_many :locations, :through => :rosters
end
