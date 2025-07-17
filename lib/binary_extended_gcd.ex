defmodule BinaryExtendedGcd do
  @moduledoc """
  Documentation for `BinaryExtendedGcd`.
  """

  def of(a, b)
  def of(0, b), do: {b, 0, 1}
  def of(a, 0), do: {a, 1, 0}

  def of(a, b) do
    {shift, a, b} = CommonTwos.of(a, b)

    sub(a, b, a, b, 1, 0, 0, 1)
    |> then(fn {v, cc, dd} -> {Bitwise.bsl(v, shift), cc, dd} end)
  end

  defp sub(0, v, _a, _b, _aa, _bb, cc, dd), do: {v, cc, dd}

  defp sub(u, v, a, b, aa, bb, cc, dd) do
    {u, a, b, aa, bb} = sub1(u, a, b, aa, bb)
    {v, a, b, cc, dd} = sub2(v, a, b, cc, dd)
    {u, v, aa, bb, cc, dd} = sub3(u, v, aa, bb, cc, dd)
    sub(u, v, a, b, aa, bb, cc, dd)
  end

  defp sub1(u, a, b, aa, bb) when Bitwise.band(u, 1) != 0 do
    {u, a, b, aa, bb}
  end

  defp sub1(u, a, b, aa, bb), do: sub11(Bitwise.bsr(u, 1), a, b, aa, bb)

  defp sub11(u, a, b, aa, bb) when Bitwise.band(aa, 1) == 0 and Bitwise.band(bb, 1) == 0 do
    {u, a, b, Bitwise.bsr(aa, 1), Bitwise.bsr(bb, 1)}
  end

  defp sub11(u, a, b, aa, bb) do
    {u, a, b, Bitwise.bsr(aa + b, 1), Bitwise.bsr(bb - a, 1)}
  end

  defp sub2(v, a, b, cc, dd) when Bitwise.band(v, 1) != 0 do
    {v, a, b, cc, dd}
  end

  defp sub2(v, a, b, cc, dd), do: sub11(Bitwise.bsr(v, 1), a, b, cc, dd)

  defp sub3(u, v, aa, bb, cc, dd) when u >= v do
    {u - v, v, aa - cc, bb - dd, cc, dd}
  end

  defp sub3(u, v, aa, bb, cc, dd) do
    {u, v - u, aa, bb, cc - aa, dd - bb}
  end
end
