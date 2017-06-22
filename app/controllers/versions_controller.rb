class VersionsController < ApplicationController
  def revert
    @version = PaperTrail::Version.find(params[:id])
    if @version.reify
      @version.reify.save!
    else
      @version.item.destroy
    end
    redirect_back(fallback_location: declaration_path)
    flash[:success] = 'Changes reverted.'
  end
end
