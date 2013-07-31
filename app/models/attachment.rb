class Attachment < ActiveRecord::Base
  attr_accessible :image, :name, :user_id
  belongs_to :user
validates_format_of :image, :with => %r{\.(png)$}i, :message => "allow png's only"
validates_presence_of :image
mount_uploader :image, ImageUploader
end
