module Concerns
  module UserAction
    def self.included base
      base.class_eval do
        helper_method :following?
      end
    end

    def following? user
      current_user.followings.include?(user)
    end
  end
end