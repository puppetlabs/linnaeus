class Character
  def character_sheet
    []
  end

  def go_on(quest)
    treasure = []
    quest.narrative do |npc|
      treasure = npc.interrogate treasure
    end
    treasure
  end
end
