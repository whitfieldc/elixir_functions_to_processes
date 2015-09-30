# processified
# defmodule NamedFunction do
#   def call do
#     receive do
#       {_pid, msg} ->
#         IO.puts "called with message #{msg}"
#     end
#   end
# end

# send message back to calling process
# defmodule NamedFunction do
#   def call do
#     receive do
#       {pid, msg} ->
#         send pid, {:ok, "called with message #{msg}"}
#     end
#   end
# end

#recursive
# defmodule NamedFunction do
#   def call do
#     receive do
#       {pid, msg} ->
#         send pid, {:ok, "called with message #{msg}"}
#         call
#     end
#   end
# end

#different responses to different messages
defmodule NamedFunction do
  def call do
    receive do
      {:pop, pid, msg} ->
        send pid, {:ok, "POP: called with message #{msg}"}
        call
      {:push, pid, msg} ->
      send pid, {:ok, "PUSH: called with message #{msg}"}
      call
    end
  end
end