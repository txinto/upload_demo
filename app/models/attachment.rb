class Attachment < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name :string
    timestamps
  end
  attr_accessible :name, :project, :project_id
  
  belongs_to :project, :inverse_of => :attachments, :creator => :true
  
  has_attached_file :document,
    :styles => {
    :medium => ["200x138#", :png],
    :thumb => ["100x100>", :png] },
    :whiny => false,
    :path => 'lib/attachments/:style/:id-:filename',
    :url => '/attachments/:id.:extension?style=:style'
  validates_attachment_size :document, { :in => 0..1500.kilobytes }
  
  def thumbnail_url(style = :original)
    if style == :original || FileTest.exists?(document.path(style))
      document.url(style)
    else
      '/assets/text-file-icon.png'
    end
  end
  
  def short_name
    splitted = document.original_filename.split('.')
    return "#{splitted[0].first(18)}.#{splitted[1]}"+
      " (#{I18n.l created_at.to_date})"
  end
    
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
