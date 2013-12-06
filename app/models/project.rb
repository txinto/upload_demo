class Project < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name :string
    description :text
    timestamps
  end
  attr_accessible :name, :attachments, :photo, :photo_file_name, :description

  has_attached_file :photo,
    :styles => {
    :medium => ["200x138#", :png],
    :thumb => ["100x100>", :png] },
    :whiny => false,
    :path => 'lib/photos/:style/:filename',
    :url => '/projects/:id?style=:style'
  
  has_many :attachments, :dependent => :destroy
  
  children :attachments
    
  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator?
  end

  def update_permitted?
    acting_user.administrator?
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    true
  end

end
