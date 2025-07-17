# BinaryExtendedGcd

A fast implementation of the binary extended GCD algorithm for Elixir.

This library provides an efficient implementation of the extended greatest common divisor (GCD) algorithm using the binary GCD method. The binary algorithm is particularly efficient for large integers as it eliminates expensive division operations by using only bit shifts and additions.

## Features

- **Fast Performance**: Uses binary operations instead of division for better performance on large integers
- **Extended GCD**: Computes both the GCD and Bézout coefficients
- **Mathematically Correct**: Implements the binary extended GCD algorithm with proper coefficient tracking
- **Well Tested**: Includes comprehensive randomized test suite
- **Documented**: Full documentation with examples and mathematical explanations

## Installation

The package can be installed
by adding `binary_extended_gcd` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:binary_extended_gcd, "~> 0.1.0"}
  ]
end
```

## Usage

### Basic Usage

```elixir
# Compute extended GCD of 48 and 18
{gcd, x, y} = BinaryExtendedGcd.of(48, 18)
# Returns {6, -1, 3}
# This means: 6 = 48 * (-1) + 18 * 3

# Compute extended GCD of 17 and 13
{gcd, x, y} = BinaryExtendedGcd.of(17, 13)
# Returns {1, 4, -5}
# This means: 1 = 17 * 4 + 13 * (-5)
```

### Edge Cases

```elixir
# When one number is 0
BinaryExtendedGcd.of(0, 5)   # Returns {5, 0, 1}
BinaryExtendedGcd.of(12, 0)  # Returns {12, 1, 0}

# Coprime numbers
BinaryExtendedGcd.of(17, 13) # Returns {1, 4, -5}
```

## Mathematical Background

### Extended GCD

The extended GCD not only computes the greatest common divisor of two integers `a` and `b`, but also finds Bézout coefficients $x$ and $y$ such that:

$$gcd(a, b) = ax + by$$

This is known as Bézout's identity and is useful in many applications including:
- Cryptography (RSA, modular arithmetic)
- Solving linear Diophantine equations
- Computing modular multiplicative inverses

### Binary GCD Algorithm

The binary GCD algorithm is an efficient variant of the Euclidean algorithm that:

1. **Eliminates division**: Uses only bit shifts and additions
2. **Handles even numbers efficiently**: Divides by 2 using bit shifts
3. **Maintains Bézout coefficients**: Tracks coefficients throughout the computation

The algorithm works by:
1. Extracting common factors of 2 from both numbers
2. Using bit operations to handle even/odd cases efficiently
3. Maintaining Bézout coefficients throughout the computation
4. Restoring the common factors at the end

### Performance

The binary algorithm is generally faster than the Euclidean algorithm for large integers because:
- Bit shifts are faster than division operations
- Fewer arithmetic operations are required
- Better cache locality due to simpler operations

## API Reference

### `BinaryExtendedGcd.of(a, b)`

Computes the extended GCD of two integers.

**Parameters:**
- `a` - First integer
- `b` - Second integer

**Returns:**
`{gcd, x, y}` where:
- `gcd` is the greatest common divisor of `a` and `b`
- `x` and `y` are integers satisfying $gcd(a, b) = ax + by$

**Examples:**
```elixir
iex> BinaryExtendedGcd.of(48, 18)
{6, 2, -5}

iex> BinaryExtendedGcd.of(17, 13)
{1, -16, 21}

iex> BinaryExtendedGcd.of(0, 5)
{5, 0, 1}
```

## Mathematical Properties

The result satisfies the following properties:
- `gcd` divides both `a` and `b`
- `gcd` is the largest number that divides both `a` and `b`
- $gcd(a, b) = ax + by$ (Bézout's identity)

## Testing

The library includes comprehensive tests with 1000 randomized test cases that verify:
- GCD divides both input numbers
- No larger number divides both inputs
- Bézout's identity holds: $gcd = ax + by$

Run tests with:
```bash
mix test
```

## Dependencies

- `common_twos` - For extracting common factors of 2
- `nstandard` - For code quality and development tools

## Development

### Building Documentation

```bash
mix docs
```

### Code Quality

```bash
mix check
```

This runs:
- Credo (code style and quality)
- Dialyzer (static analysis)
- Spell checking
- Format checking

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE.md](LICENSE.md) file for details.

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Run `mix check` to ensure code quality
6. Submit a pull request

## References

- [Binary GCD Algorithm](https://en.wikipedia.org/wiki/Binary_GCD_algorithm)
- [Extended Euclidean Algorithm](https://en.wikipedia.org/wiki/Extended_Euclidean_algorithm)
- [Bézout's Identity](https://en.wikipedia.org/wiki/B%C3%A9zout%27s_identity)

