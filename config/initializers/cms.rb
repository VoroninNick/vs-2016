Cms::CompressionConfig.initialize_compression(html_compress: false)
if !ENV["STD_PRECOMPILE"]
  Cms::AssetsPrecompile.initialize_precompile
end
Cms.config.use_translations true

Cms.config do |config|
  config.provided_locales [:en, :uk]
  config.locale_names do
    {en: :eng, uk: :ukr}
  end
end