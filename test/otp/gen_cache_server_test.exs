defmodule OTP.GenCacheServerTest do
  use ExUnit.Case

  alias OTP.GenCacheServer

  describe "solution genserver work" do
    test "initialization work" do
      {:ok, pid} = GenCacheServer.start_link()

      assert Process.alive?(pid)
      Process.exit(pid, :normal)
    end

    test "current_state work" do
      {:ok, pid} = GenCacheServer.start_link(%{test: "value"})

      assert GenCacheServer.current_state() == %{test: "value"}
      Process.exit(pid, :normal)
    end

    test "reset work" do
      {:ok, pid} = GenCacheServer.start_link(%{test: "value"})

      assert GenCacheServer.reset() == :ok
      assert GenCacheServer.current_state() == %{}
      Process.exit(pid, :normal)
    end

    test "has? work" do
      {:ok, pid} = GenCacheServer.start_link(%{test: "value"})

      assert GenCacheServer.has?(:test)
      refute GenCacheServer.has?(:some)
      Process.exit(pid, :normal)
    end

    test "add work" do
      {:ok, pid} = GenCacheServer.start_link(%{test: "value"})

      assert GenCacheServer.add(:some, 2) == :ok
      assert GenCacheServer.current_state() == %{test: "value", some: 2}
      Process.exit(pid, :normal)
    end

    test "drop work" do
      {:ok, pid} = GenCacheServer.start_link(%{test: "value"})

      assert GenCacheServer.drop(:some) == :ok
      assert GenCacheServer.current_state() == %{test: "value"}
      assert GenCacheServer.drop(:test) == :ok
      assert GenCacheServer.current_state() == %{}
      Process.exit(pid, :normal)
    end
  end
end
