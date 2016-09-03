class Post < ActiveRecord::Base
  has_many :attachments, as: :attachable
  has_many :imageables
end
