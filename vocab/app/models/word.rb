class Word < ActiveRecord::Base
  # TODO no redundant words
  validates :headword, :uniqueness => true
  has_many :search_results
  # attr_accessible :title, :body

  def unpacked_conjugates
    conjugates.split(/,/)
  end
end
