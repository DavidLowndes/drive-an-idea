class ChangeAnonymouseCommentsFromBooleanToInteger < ActiveRecord::Migration[5.0]
  def change
    change_column(:ideas, :anonymous_comments?, :integer)
  end
end
