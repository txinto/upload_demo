class HoboMigration2 < ActiveRecord::Migration
  def self.up
    add_column :attachments, :project_id, :integer

    add_index :attachments, [:project_id]
  end

  def self.down
    remove_column :attachments, :project_id

    remove_index :attachments, :name => :index_attachments_on_project_id rescue ActiveRecord::StatementInvalid
  end
end
