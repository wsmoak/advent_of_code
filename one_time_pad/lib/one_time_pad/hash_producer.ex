alias Experimental.GenStage

defmodule OneTimePad.HashProducer do
  use GenStage

  def init( {starting_with, input} ) do
    {:producer, {starting_with, input} }
  end

  def handle_demand(demand, _state = {counter, input} ) when demand > 0 do
    IO.puts "******In HashProducer, producing #{demand} keys"

    # If the counter is 3 and we ask for 2 items, we will
    # emit the items 3 and 4, and set the state to 5.
    events = generate_hashes(counter..counter+demand-1, input)

    # The events to emit is the second element of the tuple,
    # the third being the state.
    {:noreply, events, {counter + demand, input } }
  end

  def generate_hashes(range, input) do
    range
    |> Enum.to_list
    |> Enum.map(&concat(&1, input))
    |> Enum.map(&hash(&1))
  end

  def hash( {input, index} ) do
    #IO.puts "Generating hash for #{input} at index #{index}"
    hash = input |> :erlang.md5 |> Base.encode16 |> String.downcase
    {hash, index}
  end

  def concat(number, input) do
    { input <> to_string(number), number}
  end

end