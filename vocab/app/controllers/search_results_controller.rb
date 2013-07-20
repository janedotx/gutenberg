class SearchResultsController < ApplicationController
  def index
  end

  def fetch
    logger.error(params.inspect)
    @word = Word.find_by_headword(params[:q].chomp)
    if @word.blank?
      redirect_to root_path, :flash => { :error => "Use only lemmas/headwords/words I've indexed for searches!" } and return
    end
    @num_pages = @word.unpacked_search_result_ids.size / 20
    @num_pages += 1 if @word.unpacked_search_result_ids.size % 20 != 0
    @results = @word.return_page(params[:page].to_i)
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
