module PracticingRuby
  class User < ActiveRecord::Base
    establish_connection("practicing_ruby_#{Rails.env}")

    def active
      status == "active"
    end
  end
end
