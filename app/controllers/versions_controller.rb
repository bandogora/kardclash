class VersionsController < ApplicationController
  def revert
    @version = PaperTrail::Version.find(params[:id])
    if @version.reify
      @version.reify.save!
    else
      @version.item.destroy
    end
    redirect_back(fallback_location: article_path)
    flash[:success] = 'Changes successfully reverted.'
  end
end
