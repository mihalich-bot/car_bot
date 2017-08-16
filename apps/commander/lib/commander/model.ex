defmodule Commander.Model do
  @moduledoc """
  Model for command request
  """

  defmodule Command do
    @type t :: %Command{from: pid, reply_to: pid, command: atom, message: any, custom: any}
    defstruct from: nil, reply_to: nil, command: nil, message: nil, custom: nil
  end
end
