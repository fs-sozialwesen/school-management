class AddBlockedAddToLogins < ActiveRecord::Migration
  def change
    add_column :logins, :blocked_at, :date
  end
end
