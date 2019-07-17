defmodule BankAccount do
  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  use Agent

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    {:ok, account} = Agent.start_link(fn -> 0 end)
    account
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account) do
    Agent.stop(account)
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    execute_if_account_is_open(
      account,
      fn -> Agent.get(account, &(&1)) end
    )
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) do
    execute_if_account_is_open(
      account,
      fn -> Agent.update(account, &(&1 + amount)) end
    )
  end

  @spec execute_if_account_is_open(account, function) :: integer | {:error, :account_closed}
  defp execute_if_account_is_open(account, function) do
    if Process.alive?(account) do
      function.()
    else
      {:error, :account_closed}
    end
  end
end
