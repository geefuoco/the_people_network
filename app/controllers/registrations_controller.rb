class RegistrationsController < Devise::RegistrationsController

  def create
    super
    if @user.persisted?
      WelcomeMailer.welcome(@user).deliver_later
    end
  end
end