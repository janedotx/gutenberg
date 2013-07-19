class SearchResultsController < ApplicationController
  def index
  end

  def fetch
    logger.error(params.inspect)
    @word = Word.find_by_headword(params[:q])
    @num_pages = @word.number_of_results / 20
    @num_pages += 1 if @word.number_of_results % 20 != 0
    @results = @word.return_page(params[:page].to_i)
    if @word.blank?
      redirect_to index_path, :flash => { :error => "Use only lemmas/headwords for searches!" }
    end
  end

  def mark
    # TODO exception handling
    sr = SearchResult.find(params[:id].to_i)
    sr.update_mark(!sr.is_good)
    head :ok
  end

  def export
  end

  def show
    @result = SearchResult.find(params[:id].to_i)
  end
end
