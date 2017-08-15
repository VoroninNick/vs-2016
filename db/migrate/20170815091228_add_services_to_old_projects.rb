class AddServicesToOldProjects < ActiveRecord::Migration
  def up
    Portfolio.all.each do |portfolio|
      project = portfolio.project
      project_id = project.id
      service_id = nil
      portfolio_category_id = portfolio.portfolio_category_id
      if portfolio_category_id == 1
        service_id = 1
      elsif portfolio_category_id == 2
        service_id = 3
      elsif portfolio_category_id == 3
        service_id = 5
      end

      if service_id
        ActiveRecord::Base.connection.execute("INSERT INTO projects_services (project_id, service_id) VALUES (#{project_id}, #{service_id})")
      end

    end

  end
end
