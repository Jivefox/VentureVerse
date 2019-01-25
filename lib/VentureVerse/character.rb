class character

  attr_accessor :name, :episodes, :voice_actor

  def initialize(name, url)
    @name = name
    @url = url
    @episodes = []
  end

end
