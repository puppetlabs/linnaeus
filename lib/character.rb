class Character
  def character_sheet
    []
  end

  def go_on(quest)
    [*quest.treasure]
  end
end