defmodule RickAndMorty.CharacterList do
  use ExConstructor

  defstruct [
    :id,
    :image,
    :name,
    :species,
    :status
  ]

end
