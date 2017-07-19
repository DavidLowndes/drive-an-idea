#
module IdeasHelper
  
  def get_username(user_id)
    un = User.find_by(id: user_id)
    un ? un.first_name + ' ' + un.last_name : 'No User Found'
  end
end
