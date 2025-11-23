class ForceCleanupAgain < ActiveRecord::Migration[7.0]

  def up
    PrivateMessage.delete_all
    puts "--- LIXO DO BANCO REMOVIDO ---"
  end

end
