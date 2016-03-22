class PagesController < ApplicationController

  def index
    @news = News.recent.limit(10)
    @case_studies = CaseStudy.order(:created_at)
  end
end