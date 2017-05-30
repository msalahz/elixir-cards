defmodule Cards do
  @moduledoc """
   Provides methods for creating and handling a deck of cards
  """

  @doc """
  Create a new deck and return a list of cards

  ## Example

      iex> length(Cards.create_deck)
      20

  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Diamonds", "Hearts"]

    for value <- values, suit <- suits do
      "#{value} of #{suit}"
    end
  end

  @doc """
  Shulffe `deck` cards and return a new dec

    ## Example
      iex> deck = Cards.create_deck()
      iex> length(Cards.shuffle(deck))
      20
      
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
  Return a tuple with `{hand, rest}`

  ## Ecamples

      iex> deck = Cards.create_deck()
      iex> {hand, _rest} = Cards.deal(deck,2)
      iex> hand
      ["Ace of Spades", "Ace of Clubs"]
      iex> length(hand)
      2

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
  Contains?

  ## Ecamples

      iex> deck = Cards.create_deck()
      iex> Cards.contains?(deck,"Ace of Spades")
      true
      iex> Cards.contains?(deck,"Ace")
      false

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
  Save

  ## Examples

      iex> deck = Cards.create_deck()
      iex> Cards.save(deck,"my_deck")
      :ok

  """
  def save(deck, file_name) do
    binary = :erlang.term_to_binary(deck)
    File.write(file_name, binary)
  end

  @doc """
  Load

  ## Examples

      iex> deck = Cards.create_deck()
      ["Ace of Spades", "Ace of Clubs", "Ace of Diamonds", "Ace of Hearts",
      "Two of Spades", "Two of Clubs", "Two of Diamonds", "Two of Hearts",
      "Three of Spades", "Three of Clubs", "Three of Diamonds", "Three of Hearts",
      "Four of Spades", "Four of Clubs", "Four of Diamonds", "Four of Hearts",
      "Five of Spades", "Five of Clubs", "Five of Diamonds", "Five of Hearts"]
      iex> Cards.save(deck, 'my_deck')
      :ok
      iex> Cards.load("my_deck")
      ["Ace of Spades", "Ace of Clubs", "Ace of Diamonds", "Ace of Hearts",
      "Two of Spades", "Two of Clubs", "Two of Diamonds", "Two of Hearts",
      "Three of Spades", "Three of Clubs", "Three of Diamonds", "Three of Hearts",
      "Four of Spades", "Four of Clubs", "Four of Diamonds", "Four of Hearts",
      "Five of Spades", "Five of Clubs", "Five of Diamonds", "Five of Hearts"]

      iex> Cards.load("invlaid_file_name")
      "File not found"

  """
  def load(file_name) do
    case File.read(file_name) do
      {:ok, binary} -> :erlang.binary_to_term binary
      {:error, _reason} -> "File not found"
    end
  end

  @doc """
  Hand

  ## Examples

      iex> {hand, _rest} = Cards.hand(2)
      iex> length(hand)
      2

  """
  def hand(hand_size) do
    create_deck()
    |> shuffle()
    |> deal(hand_size)
  end

end
