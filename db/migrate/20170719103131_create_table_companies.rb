class CreateTableCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string :company_name
      
      t.timestamps
    end
    
    add_column :users, :company_id, :int
  end
end
