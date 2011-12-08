module CsvImport
  class Engine < Rails::Engine
=begin
    initialize "csv_import.load_app_instance_data" do |app|
      CsvImport.setup do |config|
        config.app_root = app.root
      end
    end

    initialize "csv_import.load_static_assets" do |app|
      app.middleware.use ::ActionDispatch::Static, "#{root}/public"
    end
=end
  end

end
