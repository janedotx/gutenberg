class Word < ActiveRecord::Base
  # TODO no redundant words
  validates :headword, :uniqueness => true
#  has_many :search_results
  # attr_accessible :title, :body

  def self.test_worthy_words
    Word.find(:all).select { |w| w.test_worthy }
  end

  def unpacked_conjugates
    @unpacked_conjugates ||= if conjugates.blank?
                                []
                              else
                                conjugates.split(/,/)
                              end
  end

  def unpacked_search_result_ids
    @unpacked_search_result_ids ||= Marshal.load(self.search_result_ids)
  end

  def return_page(page, num_per_page = 20)
    # TODO: what if they ask for too high of a page number?
    # TODO what if page *num_per_page is too big?
    start_index = page * num_per_page
    end_index = start_index + num_per_page
    if end_index > unpacked_search_result_ids.size
      end_index = unpacked_search_result_ids.size
    end
    SearchResult.find(unpacked_search_result_ids[start_index...end_index])
  end


=begin
  123
  page = 0
  s = 0
  end = 20

  page = 6
  s = 120
  end = 140
=end
end
