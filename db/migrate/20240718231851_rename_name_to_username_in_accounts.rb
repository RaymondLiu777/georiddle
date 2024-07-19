class RenameNameToUsernameInAccounts < ActiveRecord::Migration[7.1]
  def change
    rename_column :accounts, :name, :username
  end
end
