defmodule BinaryExtendedGcd do
  @moduledoc """
  A fast implementation of the binary extended GCD algorithm.

  This module provides an efficient implementation of the extended greatest common divisor
  (GCD) algorithm using the binary GCD method. The binary GCD algorithm is particularly
  efficient for large integers as it eliminates the need for expensive division operations
  by using only bit shifts and additions.

  ## Extended GCD

  The extended GCD not only computes the greatest common divisor of two integers `a` and `b`,
  but also finds Bézout coefficients $x$ and $y$ such that:

  $$gcd(a, b) = ax + by$$

  This is useful in many cryptographic applications, modular arithmetic, and solving
  linear Diophantine equations.

  ## Algorithm

  The binary extended GCD algorithm works by:
  1. Extracting common factors of 2 from both numbers
  2. Using bit operations to handle even/odd cases efficiently
  3. Maintaining Bézout coefficients throughout the computation
  4. Restoring the common factors at the end

  ## Performance

  The binary algorithm is generally faster than the Euclidean algorithm for large integers
  because it avoids expensive division operations, using only bit shifts and additions.

  ## Examples

      iex> BinaryExtendedGcd.of(48, 18)
      {6, 2, -5}

      iex> BinaryExtendedGcd.of(17, 13)
      {1, -16, 21}

      iex> BinaryExtendedGcd.of(0, 5)
      {5, 0, 1}

      iex> BinaryExtendedGcd.of(12, 0)
      {12, 1, 0}
  """

  @doc """
  Computes the extended GCD of two integers.

  Returns a tuple `{gcd, x, y}` where:
  - `gcd` is the greatest common divisor of `a` and `b`
  - `x` and `y` are Bézout coefficients such that $gcd(a, b) = ax + by$

  ## Parameters

  - `a` - First integer
  - `b` - Second integer

  ## Returns

  `{gcd, x, y}` where:
  - `gcd` is the greatest common divisor of `a` and `b`
  - `x` and `y` are integers satisfying $gcd(a, b) = ax + by$

  ## Examples

      iex> BinaryExtendedGcd.of(48, 18)
      {6, 2, -5}
      # 6 = 48 * 2 + 18 * (-5)

      iex> BinaryExtendedGcd.of(17, 13)
      {1, -16, 21}
      # 1 = 17 * (-16) + 13 * 21

      iex> BinaryExtendedGcd.of(0, 5)
      {5, 0, 1}
      # When one number is 0, the other is the GCD

      iex> BinaryExtendedGcd.of(12, 0)
      {12, 1, 0}
      # When one number is 0, the other is the GCD

  ## Mathematical Properties

  The result satisfies the following properties:
  - `gcd` divides both `a` and `b`
  - `gcd` is the largest number that divides both `a` and `b`
  - $gcd(a, b) = ax + by$ (Bézout's identity)
  """
  @spec of(integer(), integer()) :: {integer(), integer(), integer()}
  def of(a, b)
  def of(0, b), do: {b, 0, 1}
  def of(a, 0), do: {a, 1, 0}

  def of(a, b) do
    {shift, a, b} = CommonTwos.of(a, b)

    sub(a, b, a, b, 1, 0, 0, 1)
    |> then(fn {v, cc, dd} -> {Bitwise.bsl(v, shift), cc, dd} end)
  end

  # Main recursive function for binary extended GCD
  # Returns {gcd, x, y} where gcd = ax + by
  defp sub(0, v, _a, _b, _aa, _bb, cc, dd), do: {v, cc, dd}

  defp sub(u, v, a, b, aa, bb, cc, dd) do
    {u, a, b, aa, bb} = sub1(u, a, b, aa, bb)
    {v, a, b, cc, dd} = sub2(v, a, b, cc, dd)
    {u, v, aa, bb, cc, dd} = sub3(u, v, aa, bb, cc, dd)
    sub(u, v, a, b, aa, bb, cc, dd)
  end

  # Handle odd/even cases for first parameter u
  defp sub1(u, a, b, aa, bb) when Bitwise.band(u, 1) != 0 do
    {u, a, b, aa, bb}
  end

  defp sub1(u, a, b, aa, bb), do: sub11(Bitwise.bsr(u, 1), a, b, aa, bb)

  # Adjust Bézout coefficients when dividing by 2
  defp sub11(u, a, b, aa, bb) when Bitwise.band(aa, 1) == 0 and Bitwise.band(bb, 1) == 0 do
    {u, a, b, Bitwise.bsr(aa, 1), Bitwise.bsr(bb, 1)}
  end

  defp sub11(u, a, b, aa, bb) do
    {u, a, b, Bitwise.bsr(aa + b, 1), Bitwise.bsr(bb - a, 1)}
  end

  # Handle odd/even cases for second parameter v
  defp sub2(v, a, b, cc, dd) when Bitwise.band(v, 1) != 0 do
    {v, a, b, cc, dd}
  end

  defp sub2(v, a, b, cc, dd), do: sub11(Bitwise.bsr(v, 1), a, b, cc, dd)

  # Compare and subtract based on magnitude
  defp sub3(u, v, aa, bb, cc, dd) when u >= v do
    {u - v, v, aa - cc, bb - dd, cc, dd}
  end

  defp sub3(u, v, aa, bb, cc, dd) do
    {u, v - u, aa, bb, cc - aa, dd - bb}
  end
end
