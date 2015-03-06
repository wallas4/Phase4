class CreateEventsLocations < ActiveRecord::Migration
  def change
    create_table :events_locations, id: false do |t|
        t.belongs_to :locations, index:true
        t.belongs_to :events, index:true
    end
  end
end
