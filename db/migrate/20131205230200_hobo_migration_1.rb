class HoboMigration1 < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string   :name
      t.datetime :created_at
      t.datetime :updated_at
    end

    create_table :attachments do |t|
      t.string   :name
      t.datetime :created_at
      t.datetime :updated_at
    end
  end

  def self.down
    drop_table :projects
    drop_table :attachments
  end
end
