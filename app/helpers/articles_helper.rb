module ArticlesHelper
  def month_name(number_or_date, locale = I18n.locale)
    if number_or_date.nil?
      return nil
    end
    locales = {
        uk: %w(січня лютого березня квітня травня червня липня серпня вересня жовтня листопала грудня),
        en: %w(january february march april may june july august september october november december),
        ru: %w(январь февраль март апрель май июнь июль август сентябрь октябрь ноябрь декабрь)
    }

    num = number_or_date
    if number_or_date.respond_to? :month
      num = number_or_date.month
    end

    str = locales[locale.to_sym][num - 1]
    str[0, 3]
  end
end