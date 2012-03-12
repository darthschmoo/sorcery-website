class Publicity::Reviewer < ActiveRecord::Base
  has_many :submissions, class_name: "ReviewSubmission"
end
