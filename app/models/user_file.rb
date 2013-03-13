class UserFile < ActiveRecord::Base
  attr_accessible :file, :attached_to_id, :attached_to_type, :notes
  belongs_to :attached_to, polymorphic: true
  belongs_to :owner, class_name: "Author"
  mount_uploader :file, FileUploader
end
