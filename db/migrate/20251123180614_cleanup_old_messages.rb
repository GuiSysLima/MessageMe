class CleanupOldMessages < ActiveRecord::Migration[7.0]
  def up
    
    PrivateMessage.delete_all
    
    puts "=== BANCO DE DADOS LIMPO COM SUCESSO ==="
  end

  def down
  end
end
