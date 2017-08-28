Dir.glob('%s/models/*.rb' % Dir.pwd).each do |file|
  require_relative file
end

DataMapper.finalize
DataMapper.auto_upgrade!