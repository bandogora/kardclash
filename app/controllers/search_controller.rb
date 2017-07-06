class SearchController < ApplicationController

  def results
    return unless params[:search]
    results = Search.search(params[:search])

    @declarations = results[:declarations]
                    .paginate(page: params[:page], per_page: 10)
                    .order('created_at DESC')

    @users = results[:users]
             .paginate(page: params[:page], per_page: 10)
             .order('created_at DESC')
  end
end