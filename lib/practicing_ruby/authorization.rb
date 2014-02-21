module PracticingRuby
  class Authorization < ActiveRecord::Base
    establish_connection("practicing_ruby_#{Rails.env}")

    belongs_to :user
  end
end
