class SearchResult < ActiveRecord::Base
  # TODO uniqueness
  # TODO #to_s
  belongs_to :word
  has_one :book
  validates :book_id, :presence => true
  validates :byte_location, :presence => true
  # attr_accessible :title, :body

=begin
    t.integer  "book_id"
    t.integer  "byte_location"
    t.string   "snippet"
    t.integer  "word_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.boolean  "is_good"
    t.integer  "unique_hash"
    t.string   "uniqueness_id"
=end
  def self.export
    # TODO
  end

  def calculate_uniqueness_id
    @book_id.to_s + @byte_location.to_s + @word_id.to_s
  end

  def book
    @book ||= Book.find_by_id(self.book_id)
  end

end
