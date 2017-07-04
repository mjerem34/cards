defmodule Cards do
  def create_deck do
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]
    values = ["Ace", "Two", "Three", "Four", "Five"]
    cards = for value <- values, suit <- suits do
      "#{value} of #{suit}"
    end
    List.flatten(cards)
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  def deal(deck, number_of_cards) do
    { hand, _rest_of_deck } = Enum.split(deck, number_of_cards)
    hand
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def read(filename) do
    case File.read(filename) do
      {:ok, deck} -> :erlang.binary_to_term(deck)
      {:error, _reason} -> "File does not exists !"
    end
  end

  def create_hand(number_of_cards) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(number_of_cards)
  end
end
