Cms::CompressionConfig.initialize_compression(enable_compression: false)

Cms.config.use_translations true

Cms.config do |config|
  config.provided_locales [:en, :uk]
  config.locale_names do
    {en: :eng, uk: :ukr}
  end
end