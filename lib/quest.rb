class Quest
  def initialize(*npcs)
    @npcs = npcs
  end

  def narrative(&block)
    @npcs.each(&block)
  end
end
