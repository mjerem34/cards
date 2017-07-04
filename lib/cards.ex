defmodule Cards do
  @moduledoc """
    This module provides many function for interact with an deck
  """

  @doc """
    Create an deck

  ## Examples

      iex> deck = Cards.create_deck
      iex> deck
      ["Ace of Spades", "Ace of Clubs", "Ace of Hearts", "Ace of Diamonds",
       "Two of Spades", "Two of Clubs", "Two of Hearts", "Two of Diamonds",
       "Three of Spades", "Three of Clubs", "Three of Hearts", "Three of Diamonds",
       "Four of Spades", "Four of Clubs", "Four of Hearts", "Four of Diamonds",
       "Five of Spades", "Five of Clubs", "Five of Hearts", "Five of Diamonds"]

  """
  def create_deck do
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]
    values = ["Ace", "Two", "Three", "Four", "Five"]
    cards = for value <- values, suit <- suits do
      "#{value} of #{suit}"
    end
    List.flatten(cards)
  end

  @doc """
    Shuffle the deck send in params

  ## Examples

      iex> Cards.create_deck
      ["Ace of Spades", "Ace of Clubs", "Ace of Hearts", "Ace of Diamonds",
       "Two of Spades", "Two of Clubs", "Two of Hearts", "Two of Diamonds",
       "Three of Spades", "Three of Clubs", "Three of Hearts", "Three of Diamonds",
       "Four of Spades", "Four of Clubs", "Four of Hearts", "Four of Diamonds",
       "Five of Spades", "Five of Clubs", "Five of Hearts", "Five of Diamonds"]

      iex > Cards.shuffle(deck)
      ["Two of Spades", "Four of Diamonds", "Ace of Hearts", "Three of Hearts",
      "Ace of Clubs", "Five of Diamonds", "Five of Spades", "Ace of Spades",
      "Four of Spades", "Four of Hearts", "Five of Clubs", "Three of Clubs",
      "Two of Diamonds", "Two of Hearts", "Five of Hearts", "Three of Spades",
      "Ace of Diamonds", "Three of Diamonds", "Two of Clubs", "Four of Clubs"]

  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Ask if the `deck` contain the `card`

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "King of Hearts")
      false
      iex> Cards.contains?(deck, "Two of Spades")
      true

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Give a hand of cards depends on `number_of_cards`

  """
  def deal(deck, number_of_cards) do
    { hand, _rest_of_deck } = Enum.split(deck, number_of_cards)
    hand
  end

  @doc """
    Save the `deck` in a file

  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
    Read from a file

  """
  def read(filename) do
    case File.read(filename) do
      {:ok, deck} -> :erlang.binary_to_term(deck)
      {:error, _reason} -> "File does not exists !"
    end
  end

  @doc """
    Create the deck, shuffle-it and deal the cards depends of `number_of_cards`

  """
  def create_hand(number_of_cards) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(number_of_cards)
  end
end
