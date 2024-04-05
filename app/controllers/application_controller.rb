class ApplicationController < ActionController::Base
  helper RoleHelper

  private

  def after_sign_in_path_for(_resource)
    dashboard_index_path
  end
end
