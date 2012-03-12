class Publicity::ReviewSubmission < ActiveRecord::Base
  belongs_to :reviewer
  belongs_to :book
end
