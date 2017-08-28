module DBModels
    class Information
      include DataMapper::Resource
  
      storage_names[:default] = 'information'
  
      property :id,             Serial
      property :title,          String
      property :text,           String

    end
  end
  