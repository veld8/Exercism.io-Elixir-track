defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
          :monday
          | :tuesday
          | :wednesday
          | :thursday
          | :friday
          | :saturday
          | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @weekdays %{
    monday: 1,
    tuesday: 2,
    wednesday: 3,
    thursday: 4,
    friday: 5,
    saturday: 6,
    sunday: 7
  }

  @day_range %{
    first: 1..7,
    second: 8..14,
    third: 15..21,
    fourth: 22..29,
    teenth: 13..19,
    last: 31..23
  }

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date()
  def meetup(year, month, weekday, schedule) do
    day =
      Enum.find(@day_range[schedule], fn x -> check_day?({year, month, x}, @weekdays[weekday]) end)

    Date.new!(year, month, day)
  end

  @spec check_day?(:calendar.date(), pos_integer) :: boolean()
  defp check_day?(date, weekday) do
    :calendar.valid_date(date) && :calendar.day_of_the_week(date) == weekday
  end
end
