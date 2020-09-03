class Admin::AdminController < ApplicationController
  class NotAuthorizedError < StandardError; end
  before_action :admin_required

  private

  def admin_required
    raise NotAuthorizedError, '権限がありません。' unless current_user.admin?
  end
end
