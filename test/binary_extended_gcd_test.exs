defmodule BinaryExtendedGcdTest do
  use ExUnit.Case
  doctest BinaryExtendedGcd

  @max 1_000_000

  test "randomized test" do
    1..1_000
    |> Enum.map(fn _ -> {:rand.uniform(@max), :rand.uniform(@max)} end)
    |> Enum.map(fn {a, b} -> {BinaryExtendedGcd.of(a, b), a, b} end)
    |> Enum.map(fn {{gcd, aa, bb}, a, b} ->
      assert rem(a, gcd) == 0
      assert rem(b, gcd) == 0

      (gcd + 1)..min(a - 1, b - 1)
      |> Enum.map(fn p ->
        assert rem(a, p) != 0 || rem(b, p) != 0
      end)

      assert gcd == aa * a + bb * b
    end)
  end
end
