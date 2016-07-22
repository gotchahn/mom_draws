class ExternalController < ApplicationController
  skip_before_action :authenticate
  layout 'external'

  def index
  end
end
