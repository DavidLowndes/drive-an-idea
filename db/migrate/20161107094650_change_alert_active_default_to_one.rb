class ChangeAlertActiveDefaultToOne < ActiveRecord::Migration[5.0]
  def change
    change_column_default :alerts, :active, 1
  end
end
