module DBModels
  class Team
    include DataMapper::Resource

    storage_names[:default] = 'teams'

    property :id,             Serial
    property :name,           String, :required => true, :unique => true
    property :other_names,    String


    has n, :informations
  end
end
