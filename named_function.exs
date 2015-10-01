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
# defmodule NamedFunction do
#   def call do
#     receive do
#       {:pop, pid, msg} ->
#         send pid, {:ok, "POP: called with message #{msg}"}
#         call
#       {:push, pid, msg} ->
#       send pid, {:ok, "PUSH: called with message #{msg}"}
#       call
#     end
#   end
# end

#maintaining state with processes
# defmodule NamedFunction do
#   def call(count \\ 0) do
#     receive do
#       {:pop, pid, msg} ->
#         send pid, {:ok, "POP, message number [#{count + 1}] #{msg}"}
#         call(count + 1)
#       {:push, pid, msg} ->
#       send pid, {:ok, "PUSH, message number [#{count + 1}] #{msg}"}
#         call(count + 1)
#     end
#   end
# end

#convert into stack step 1
# defmodule Stack do
#   def call(list \\ [1,2,3]) do
#     receive do
#       {:pop, pid, msg} ->
#         send pid, {:ok, "POP: called with message: #{msg}"}
#         call(list)
#       {:push, pid, msg} ->
#       send pid, {:ok, "PUSH: called with message: #{msg}"}
#         call(list)
#     end
#   end
# end

#step 2, implement pop
# defmodule Stack do
#   def call(list \\ [1,2,3]) do
#     receive do
#       {:pop, pid} ->
#         [head|tail] = list
#         send pid, {:ok, head}
#         call(tail)
#     end
#   end
# end

#step 3, implement show
# defmodule Stack do
#   def call(list \\ [1,2,3]) do
#     receive do
#       {:pop, pid} ->
#         [head|tail] = list
#         send pid, {:ok, head}
#         call(tail)
#       {:show, pid} ->
#         send pid, {:ok, list}
#         call(list)
#     end
#   end
# end

#step 4, implement push
defmodule Stack do
  def call(list \\ [1,2,3]) do
    receive do
      {:pop, pid} ->
        [head|tail] = list
        send pid, {:ok, head}
        call(tail)
      {:show, pid} ->
        send pid, {:ok, list}
        call(list)
      {:push, pid, item} ->
        send pid, {:ok, :pushed}
        call([item | list])
    end
  end
end