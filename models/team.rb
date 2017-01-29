module DBModels
  class Team
    include DataMapper::Resource

    storage_names[:default] = 'teams'

    property :id,             Serial
    property :name,           String
    property :other_names,    String
  end
end
