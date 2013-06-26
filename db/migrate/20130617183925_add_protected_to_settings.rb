class AddProtectedToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :protected, :string, default: ""
  end
end
