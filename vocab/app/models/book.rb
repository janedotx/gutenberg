class Regexp
  def each_match(str)
    start = 0
    while matchdata = self.match(str, start)
      yield matchdata
      start = matchdata.end(0)
    end
  end
end

class Book < ActiveRecord::Base
  SNIPPET_HALF_LENGTH = 100
  # attr_accessible :title, :body

  validates :file, :uniqueness => true

  def build_index_specific_word(word)
    f = File.open(BOOK_FILE_ROOT + self.file)
    text = f.read
    f.close

    words = [word.headword] + word.unpacked_conjugates
    words.each do |w|
      Regexp.new(w, ['i']).each_match(text) do |match|
        s = SearchResult.new
        s.book_id = self.id
        s.byte_location = match.offset(0)[0]
        s.word_id = word.id
        s.snippet = text[(s.byte_location - SNIPPET_HALF_LENGTH)...(s.byte_location + SNIPPET_HALF_LENGTH)]
        s.save
      end
    end
  end
    
  def build_index(words)
    words.each do |word|
      build_index_specific_word(word)
    end
  end
end
