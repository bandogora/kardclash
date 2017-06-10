class VersionsController < ApplicationController
  def revert
    @version = Version.find(params[:id])
    @version.reify.save!
    redirect_back(fallback_location: article_path)
    flash[:success] = "Undid #{@version.event}"
  end
end
