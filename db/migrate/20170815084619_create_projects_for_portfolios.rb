class CreateProjectsForPortfolios < ActiveRecord::Migration
  def up
    Portfolio.where(project_id: nil).each do |portfolio|
      project = OldProject.create(published: 't', released_on: portfolio.release)
      portfolio.project_id = project.id
      portfolio.save
    end
  end
end
