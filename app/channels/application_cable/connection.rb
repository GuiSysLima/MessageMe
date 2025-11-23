module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      user = env['warden'].user
      
      if user
        puts "✅ Action Cable: Usuário encontrado! ID: #{user.id}"
        user
      else
        puts "❌ Action Cable: Nenhum usuário logado ou cookie inválido."
        reject_unauthorized_connection
      end
    end
  end
end