class Episodes

  attr_accessor :name, :Characters

  @@all = []

  def initialize(name)
    @name = name
    @@all << self
  end
end
