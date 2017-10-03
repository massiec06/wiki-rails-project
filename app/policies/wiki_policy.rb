class WikiPolicy < ApplicationPolicy

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.admin?
        scope.all
      elsif user.premium?
        scope.all
      elsif user.standard?
        # scope.all
        scope.where('private = ? OR private IS NULL', false)
      else
        []
      end
    end
  end
end
