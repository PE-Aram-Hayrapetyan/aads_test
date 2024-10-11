# frozen_string_literal: true

module Objects
  class User
    attr_reader :id, :email

    def initialize(id)
      @id = id
      compile
    end

    def self.from_array(users)
      users.map { |user| new(user.id) }
    end

    private

    def compile
      user = ::User.find(id)
      @email = user.email
    end
  end
end
