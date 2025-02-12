defmodule Otp.Messenger do
  # To simulate the error and task failure in cas of the phone_number passed as argument is 3.
  def send_message(3) do
    # Simulate some processing time
    Process.sleep(3000)
    # Boom, it will raise an error!
    IO.puts("Sending message to #{3 + "a"}")
    {:ok, "sent"}
  end

  def send_message(phone_number) do
    # Simulate some processing time
    Process.sleep(3000)
    IO.puts("Sending message to #{phone_number}")
    {:ok, "sent"}
  end

  def send_to_all_sync(phone_numbers) do
    Enum.each(phone_numbers, &send_message/1)
  end

  def send_to_all_with_task(phone_numbers) do
    Enum.each(phone_numbers, fn phone_number ->
      Task.start(fn -> send_message(phone_number) end)
    end)
  end

  def send_to_all_with_await(phone_numbers) do
    phone_numbers
    |> Enum.map(fn phone_number ->
      Task.async(fn -> send_message(phone_number) end)
    end)
    |> IO.inspect(label: "started tasks++++")
    |> Enum.map(fn task -> Task.await(task) end)
  end

  def send_to_all_with_yield(phone_numbers) do
    phone_numbers
    |> Enum.map(fn phone_number ->
      Task.async(fn -> send_message(phone_number) end)
    end)
    |> IO.inspect(label: "started tasks++++")
    |> Enum.map(fn task -> Task.yield(task) end)
  end

  def send_all_with_async_stream(phone_numbers) do
    phone_numbers
    |> Task.async_stream(fn phone_number -> send_message(phone_number) end)
  end

  def send_all_with_async_stream_run(phone_numbers) do
    phone_numbers
    |> Task.async_stream(fn phone_number -> send_message(phone_number) end)
    |> Stream.run()
  end

  def send_all_with_async_stream_and_result(phone_numbers) do
    phone_numbers
    |> Task.async_stream(fn phone_number -> send_message(phone_number) end)
    |> Enum.to_list()
  end
end
