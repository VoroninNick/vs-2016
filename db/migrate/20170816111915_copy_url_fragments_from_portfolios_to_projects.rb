class CopyUrlFragmentsFromPortfoliosToProjects < ActiveRecord::Migration
  def up
    Portfolio.all.each do |portfolio|
      project = portfolio.project
      attrs = ["url_fragment"]
      I18n.available_locales.each do |locale|
        portfolio_translation = portfolio.translations_by_locale[locale]
        project_translation = project.translations_by_locale[locale]

        project_translation ||= Project.translation_class.new(project_id: project.id, locale: locale)
        attrs.each do |attr_name|
          attr_value = portfolio_translation.send(attr_name)
          puts "portfolio ##{portfolio.id}: #{locale}##{project_translation.id}: #{attr_name}: #{attr_value.inspect}"
          project_translation.send(:"#{attr_name}=", attr_value)
        end

        project_translation.save
      end

    end
  end
end

