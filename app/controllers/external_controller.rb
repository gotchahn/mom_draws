class ExternalController < ApplicationController
  skip_before_action :authenticate
  layout 'external'

  def index
    if current_user
      redirect_to events_path
    end
  end
end
