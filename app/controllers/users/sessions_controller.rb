class Users::SessionsController < Devise::SessionsController
  def after_sign_in_path_for(resource)
    if resource.sign_in_count == 1 && resource.worker?
      new_user_steps_path
    else
      posts_path
    end
  end
end
