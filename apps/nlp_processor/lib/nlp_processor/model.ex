defmodule NlpProcessor.Model do

  defmodule Query do

    @type t :: %Query{from: pid, reply_to: pid, query: String.t, session_id: String.t, message: any, custom: any}
    defstruct from: nil, reply_to: nil, query: nil, session_id: nil, message: nil, custom: nil
  end
end
