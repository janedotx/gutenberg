class Word < ActiveRecord::Base
  # TODO no redundant words
  has_many :search_results
  # attr_accessible :title, :body

  def unpacked_conjugates
    conjugates.split(/,/)
  end
end
