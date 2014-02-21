class SessionsController < ApplicationController
  before_filter :check_permissions, :only => [:create]

  def create
    unless user = User.find_by_uid(auth_hash['uid'])
      user = User.create_from_hash(auth_hash,
              :email => practicing_ruby_user.contact_email)
    end

    if user.errors.any?
      flash[:error] = user.errors.full_messages.join(", ")
    else
      self.current_user = user
    end

    redirect_to request.env['omniauth.origin'] || root_path
  end

  def destroy
    self.current_user = nil

    redirect_to root_path
  end

  def failure
    flash[:error] = "There was a problem logging in. Please try again"

    self.current_user = nil # Try destroying the current_user

    redirect_to root_path
  end

  private

  def auth_hash
    hash = request.env['omniauth.auth']
    hash['uid'] = hash['uid'].to_s

    hash
  end

  def nick
    auth_hash['info']['nickname']
  end

  def uid
    auth_hash['uid']
  end

  def practicing_ruby_user
    @practicing_ruby_user ||= PracticingRuby::Authorization
      .find_by_github_uid(uid).try(:user)
  end

  def check_permissions
    user = practicing_ruby_user

    unless user.try(:active)
      logger.warn "[session] #{nick} isn't a subscriber"
      redirect_to root_path,
        :alert => "Your github account is not an active Practicing Ruby subscriber"
    end
  end
end
