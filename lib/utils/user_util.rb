module Util
    class User
      def self.update_user_mail(id, email)
        return false if email.nil? or email.empty?
        return false unless DBModels::User.first(:email => email).nil?
        user = DBModels::User.get(id)
        user.update(:email => email)
      end

      def self.update_user_name(id, name)
        return false if name.nil? or name.empty?
        user = DBModels::User.get(id)
        user.update(:full_name => name)
      end

      def self.update_user_favourite_name(id, team_name)
        return false if team_name.nil? or team_name.empty?
        user = DBModels::User.get(id)
        p user.update(:fav_team => team_name)
      end

      def self.current_user_as_hash(id)
        user = DBModels::User.get(id)
        user_hash = { :full_name => user.full_name, 
                      :email => user.email,
                      :fav_team => user.fav_team } 
      end
    end
  end
  