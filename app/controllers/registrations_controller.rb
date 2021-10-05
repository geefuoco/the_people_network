class RegistrationsController < Devise::RegistrationsController
  before_action :get_recent_notifications, only: :edit

  def create
    super
    if @user.persisted?
      WelcomeMailer.welcome(@user).deliver_later
    end
  end
end