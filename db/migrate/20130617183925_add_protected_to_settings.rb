class AddProtectedToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :protected, :boolean, default: false
  end
end
