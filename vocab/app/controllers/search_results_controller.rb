class SearchResultsController < ApplicationController
  def index
  end

  def fetch
    @word = Word.find_by_headword(params[:q])
    @results = SearchResult.find_all_by_word_id(@word.id)
    if @word.blank?
      redirect_to index_path, :flash => { :error => "Use only lemmas/headwords for searches!" }
    end
  end

  def mark
    # TODO exception handling
    sr = SearchResult.find(params[:id].to_i)
    sr.is_good = !sr.is_good
    sr.save
    head :ok
  end

  def results
  end

  def export
  end
end
