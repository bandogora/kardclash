class Search < ApplicationRecord
  def self.search(search)
    users = User.where('username iLike ?', "%#{search}")
    declarations = Declaration
                   .where('title iLIKE ? OR
                   description iLIKE ? OR
                   thread iLIKE ?',
                          "%#{search}%", "%#{search}%", "%#{search}%")
    { users: users, declarations: declarations }

  end
end