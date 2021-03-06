module DBModels
  class Team
    include DataMapper::Resource

    storage_names[:default] = 'teams'

    property :id,             Serial
    property :name,           String, :required => true, :unique => true
    property :other_names,    String


    has n, :informations


    def remove_team(team_name)
      team = DBModels::Team.first(:name => team_name)
      not_found = "Could not find team with name = #{team_name}."
      raise TeamNotFoundError.new(not_found) if team.nil?
      team.destroy
    end
  end
end
