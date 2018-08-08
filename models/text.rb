require_relative '../config/db'

class Text < Sequel::Model

  def user
    ::User[self[:user_id]]
  end

end
