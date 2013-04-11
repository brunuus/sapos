class CreateResearchAreas < ActiveRecord::Migration
  def self.up
    create_table :research_areas do |t|
      t.string :name
      t.string :code

      t.timestamps
    end
  end

  def self.down
    drop_table :research_areas
  end
end