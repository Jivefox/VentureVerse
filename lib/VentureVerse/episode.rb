class Episodes

  attr_accessor :name, :characters

  @@all = []

  def initialize(name)
    @name = name
    @@all << self
  end
end
