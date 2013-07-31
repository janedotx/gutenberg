class WordsController < ApplicationController
  def worthy_words
    @words = Word.test_worthy_words
  end

  def good_results
    @word = Word.find_by_headword(params[:headword])
    @results = SearchResult.find(@word.unpacked_good_search_result_ids)
  end
end
