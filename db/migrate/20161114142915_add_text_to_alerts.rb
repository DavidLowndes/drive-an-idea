class AddTextToAlerts < ActiveRecord::Migration[5.0]
  def change
    add_column :alerts, :text, :string, default: 'New Alert!'
  end
end
