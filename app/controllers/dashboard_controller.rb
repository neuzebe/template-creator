class DashboardController < ApplicationController

  def index
    @document_templates = DocumentTemplate.all
  end
end