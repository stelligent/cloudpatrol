class AddMaskedToSetting < ActiveRecord::Migration
  def change
    add_column :settings, :masked, :boolean, default: false
  end
end
