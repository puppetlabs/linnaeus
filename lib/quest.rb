class Quest
  attr_reader :treasure

  def initialize(treasure = nil)
    @treasure = treasure
  end
end