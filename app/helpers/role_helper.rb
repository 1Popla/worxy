module RoleHelper
  def partial_name(user, partial_name)
    ["shared", user.role.pluralize, partial_name].join("/")
  end
end
