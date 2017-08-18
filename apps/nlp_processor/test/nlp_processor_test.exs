defmodule NlpProcessorTest do
  use ExUnit.Case
  doctest NlpProcessor

  test "greets the world" do
    assert NlpProcessor.hello() == :world
  end
end
