defmodule OTP.RatesMonitor do
	use GenServer


	@default_server :rates_monitor
	#@refresh_interval :timer.seconds(5)
	#:sys.trace(pid, true) # turn on event printing
	# :sys.no_debug(pid) # turn off all debug handlers

	# Client

  def start_link(opts \\ []) do
		opts = Keyword.put_new(opts, :name, @default_server)
    GenServer.start_link(__MODULE__, %{}, opts)
  end

	def get_rates(pid \\ @default_server, from_currency, to_currency) do
		GenServer.call(pid, {:get_rates, %{from_currency: from_currency, to_currency: to_currency}})
	end

  # Server (callbacks)

  @impl true
  def init(old_state) do
		#schedule_refresh()
    {:ok, old_state}
  end

  @impl true
  def handle_call({:get_rates, state}, _from, old_state) do
		new_state = fetch_rates(state)
    {:reply, new_state, old_state}
  end

	@impl true
  def handle_info(:refresh, old_state) do
    IO.puts "Refreshing the rates..."
    new_state = fetch_rates(old_state)
    #schedule_refresh()
    {:noreply, new_state}
  end

	defp fetch_rates(state) do
		%{from_currency: state.from_currency, to_currency: state.to_currency, rate: :rand.uniform(1000)}
	end

  #defp schedule_refresh do
  #  Process.send_after(self(), :refresh, @refresh_interval)
  #end
end
