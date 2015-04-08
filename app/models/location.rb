class Location < ActiveRecord::Base
    has_and_belongs_to_many :events
    has_and_belongs_to_many :participants
    has_many :roster
    has_many :participants, :through => :rosters
end
