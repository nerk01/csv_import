class CsvImportController < ::ApplicationController
  before_filter :authenticate
  before_filter :access_check
  
    def upload
      if request.post?
        uploaded = params[:file]
        target = Rails.root.join('tmp', uploaded.original_filename)
        logger.info uploaded.class.to_s
        File.open(target, 'w') do |file|
          file.write(File.open(uploaded.tempfile.path,'r',:encoding => "UTF-8").read)            
        end
        session[:csv_file] = target
        
        redirect_to eval (params[:resource] + '_csv_import_map_path')
      end
    end
    
    def map
      require 'csv'
      reader = CSV.read(session[:csv_file], :encoding => "UTF-8") 
      @heading = reader.shift  
      @model = eval(params[:model]).new
      @attributes = @model.attribute_names
      ["id","created_at","updated_at"].each do |column|
        @attributes.delete(column)
      end
    end

    def import
      reader = CSV.read(session[:csv_file], :encoding => "UTF-8") 
      @invalid_recs = Array.new
      reader.each do |row|
        model = eval(params[:model]).new
        params[:attributes].each do |e,i|
          model[e.to_sym] = row[i.to_i] unless i == "None"
        end
        if model.valid?
          model.save
        else
          @invalid_recs << model
        end
      end
      File.delete(session[:csv_file])
      session[:csv_file] = nil
      if @invalid_recs.empty?
        flash[:notice] = "Successful import."
        redirect_to eval (params[:resource] + '_csv_import_upload_path')
      end
    end
    
    private

      def access_check
        redirect_to :root unless current_user.is_admin?("Data")
      end
      
end