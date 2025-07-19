# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.1] - 2025-07-19

### Changed
- **Refactored** the main algorithm pipeline for improved readability
- **Extracted** pipeline steps into named functions (`reduce/1` and `epilogue/1`)
- **Improved** code maintainability by making algorithm flow more explicit
- **Enhanced** self-documenting code structure

### Technical Details
- Replaced anonymous functions in `then/2` callbacks with dedicated private functions
- Added `reduce/1` function to handle the main algorithmic step
- Added `epilogue/1` function to handle the final bit shift operation
- Maintained exact same functionality while improving code structure

## [1.0.0] - 2025-07-17

### Added
- **Initial release** of Binary Extended GCD implementation
- **Fast binary extended GCD algorithm** for Elixir
- **Comprehensive documentation** with mathematical explanations
- **Complete test suite** covering edge cases and mathematical properties
- **Development tooling** including Dialyzer, Credo, and Spellweaver

### Features
- **Binary Extended GCD Algorithm**: Efficient implementation using bit operations
- **Bézout Coefficients**: Computes coefficients x, y such that gcd(a,b) = ax + by
- **Mathematical Documentation**: Comprehensive docs with LaTeX math notation
- **Performance Optimized**: Avoids expensive division operations using bit shifts
- **Edge Case Handling**: Proper handling of zero inputs and special cases

### Technical Implementation
- **Core Algorithm**: Binary extended GCD with bit manipulation
- **Common Factors Extraction**: Efficient handling of common factors of 2
- **Recursive Structure**: Clean recursive implementation with proper coefficient tracking
- **Type Specifications**: Complete @spec annotations for all public functions
- **Documentation**: Extensive @moduledoc and @doc with examples

### Development Tools
- **Dialyzer**: Static analysis for type checking
- **Credo**: Code quality and consistency checks
- **Spellweaver**: Documentation spelling verification
- **ExDoc**: Beautiful documentation generation with KaTeX math rendering
- **Mix Tasks**: Comprehensive development workflow aliases

### Examples
```elixir
iex> BinaryExtendedGcd.of(48, 18)
{6, 2, -5}
# 6 = 48 * 2 + 18 * (-5)

iex> BinaryExtendedGcd.of(17, 13)
{1, -16, 21}
# 1 = 17 * (-16) + 13 * 21
```

---

## Version History

- **1.0.1**: Refactored for improved code readability and maintainability
- **1.0.0**: Initial release with complete binary extended GCD implementation

## Contributing

This project follows the [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) format for changelog entries.

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE.md](LICENSE.md) file for details.
