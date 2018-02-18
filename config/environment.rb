module Config
  class Environment
    def setup(is_migration)
      load_models
      finalize_mapper(is_migration)
    end

    private

    def add_admin
    end

    def load_models
      Dir.glob('%s/models/*.rb' % Dir.pwd).each do |file|
        require_relative file
      end
    end

    def finalize_mapper(is_migration)
      DataMapper.finalize
      DataMapper.auto_upgrade! if !is_migration
      DataMapper.auto_migrate! if is_migration
    end
  end
end