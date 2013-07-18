class WordsController < ApplicationController
  def worthy_words
    @words = Word.test_worthy_words
  end
end
