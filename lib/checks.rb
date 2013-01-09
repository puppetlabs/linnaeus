module Checks
  def has(property_name, matcher)
    ->(character) do
      matcher.call(character.character_sheet[property_name.to_sym])
    end
  end

  def aint(value)
    ->(character_value) do
      character_value != value
    end
  end

  def is(value)
    ->(character_value) do
      character_value == value
    end
  end

  def like(value)
    ->(character_value) do
      character_value =~ value
    end
  end

  def greater_than(value)
    ->(character_value) do
      character_value && character_value > value
    end
  end

  def less_than(value)
    ->(character_value) do
      character_value && character_value < value
    end
  end
end