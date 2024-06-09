class Author
  attr_reader :name, :email

  def initialize(name, email)
    @name = name
    @email = email
  end

  def to_s
    "Author: #{@name} (#{@mail})"
  end
end
