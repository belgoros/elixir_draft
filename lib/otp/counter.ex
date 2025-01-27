defmodule OTP.Counter do
  def init(parent, initial_state \\ 0) do
    process(parent, initial_state)
  end

  defp process(parent, state) do
    receive do
      :inc ->
        new_state = state + 1
        send(parent, {:ok, new_state})
        process(parent, new_state)

      :dec ->
        new_state = state - 1
        send(parent, {:ok, new_state})
        process(parent, new_state)

      :current ->
        send(parent, {:ok, state})
        process(parent, state)

      :reset ->
        send(parent, {:ok, 0})
        process(parent, 0)
    end
  end
end

parent = self()
counter = spawn(fn -> OTP.Counter.init(parent) end)

send(counter, :current)

# для просмотра почтового ящика родительского процесса
# далее по коду будет подразумеваться, что эта строчка кода
# будет вызываться после каждой отправки сообщения другому процессу
Process.info(parent, :messages)
# => {:messages, [ok: 0]}

send(counter, :inc)
# => {:ok, 1}
send(counter, :inc)
# => {:ok, 2}

send(counter, :dec)
# => {:ok, 1}

send(counter, :inc)
# => {:ok, 2}

send(counter, :reset)
# => {:ok, 0}

send(counter, :dec)
# => {:ok, -1}
