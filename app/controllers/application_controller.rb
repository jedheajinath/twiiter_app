class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :layout_by_resource

  require 'will_paginate/array'

  def after_sign_in_path_for(user)
    home_path
  end

  protected
    def layout_by_resource
      if user_signed_in?
       'master'
      else
       'application'
      end
    end
end
