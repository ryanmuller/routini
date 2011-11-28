module RolesHelper
  def role_options
    options = [["none", ""]]
    roles = Role.where("user_id = ?", current_user.id)
    roles.each do |role|
      options << [role.name, role.id]
    end
    return options
  end

end
