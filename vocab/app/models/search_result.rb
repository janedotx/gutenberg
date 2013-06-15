class SearchResult < ActiveRecord::Base
  # TODO uniqueness
  # TODO #to_s
  belongs_to :word
  has_one :book
  # attr_accessible :title, :body

  def self.export
    # TODO
  end

  def book
    @book ||= Book.find_by_id(self.book_id)
  end

end
