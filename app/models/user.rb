class User < ActiveRecord::Base
  attr_accessible :uname,:attachments_attributes
has_many :attachments, :dependent => :destroy
                  accepts_nested_attributes_for :attachments, :allow_destroy => true
end
