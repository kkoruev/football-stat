require 'data_mapper'
require 'dm-noisy-failures'

DataMapper.setup(:default, 'mysql://root:root@localhost:3306/football_stat_test')