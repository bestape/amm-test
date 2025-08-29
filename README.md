# OrbSwap.org - A Roadmap for a Generalized AMM

## Vision

<img width="1024" height="1536" alt="image" src="https://github.com/user-attachments/assets/a6714919-6bdd-46e0-b2a5-2be13fd8eee2" /><br />

OrbSwap.org is a research project dedicated to building a new generation of automated market makers (AMMs). Our goal is to move beyond the fixed-curve models of today and create a more flexible, generalized system that allows for the creation of liquidity pools with custom, mathematically-derived properties.

This document outlines our progress to date and the next steps in our roadmap.

---

## Phase 1: Validation and Proof-of-Concept (Complete)

The first phase of our research was to establish a solid mathematical foundation for our new AMM. This involved two key steps:

### 1. Deconstructing Uniswap V3 with Base Scale Calculus

We began by proving that the pricing mechanism at the heart of Uniswap V3, the `TickMath` library, is a specific instance of a more general theory called **Base Scale Calculus**.

*   **The Theory**: Base Scale Calculus defines the price-tick relationship through the formula `d = (c - b) / a`, where `a`, `b`, and `c` are the sides of a Pythagorean triple. The price is then a function of `(1/d)^tick`.
*   **The Implementation**: We created a new library, `BaseScaleTickMath.sol`, which is functionally identical to Uniswap's `TickMath`. In this library, we have explicitly included the constants for the Pythagorean triple that generates Uniswap's `d = 1/1.0001`, and a function that calculates `d` from them.
*   **The Validation**: We have a comprehensive test suite that proves our `BaseScaleTickMath` library produces the exact same results as the original, confirming that our theory is a valid generalization.

### 2. The Generative Method: "Metallic Fibonacci" Sequences

<img width="1024" height="1536" alt="image" src="https://github.com/user-attachments/assets/8347d5f8-bd1c-4022-9931-688085e1609c" /><br />

Uniswap's `TickMath` relies on a set of hard-coded, pre-calculated constants. This is efficient, but not flexible. Our goal is to generate these constants on-chain from a simple, elegant recurrence relation.

*   **The Method**: We have implemented a proof-of-concept for this generative method in the `MetallicSequenceTest.sol` contract.
*   **The Proof**: This test uses a single, unified recurrence relation based on the Pell-Lucas numbers (OEIS A001333) to generate a highly accurate approximation of `sqrt(2)`. We then validate this approximation using Pell's equation, `x^2 - 2y^2 = ±1`, which provides a perfect, integer-based verification of the method's correctness.
*   **The Significance**: This successful test proves that we can generate the necessary mathematical constants for a `TickMath`-like library from a simple, on-chain recurrence. This is the key to unlocking a fully generalized system.

---

## Phase 2: Full Generalization (Next Steps)

With our foundational research and proof-of-concept complete, we are now ready to move on to the next phase of development:

1.  **Parameterize the Base**: We will modify our `BaseScaleTickMath` library to accept the parameters of the base (`a`, `b`, `c`) as inputs, rather than relying on constants.
2.  **On-Chain Generation**: We will replace the hard-coded approximation values with functions that use our "Metallic Fibonacci" method to generate them on-the-fly.
3.  **Gas Optimization**: We will focus on optimizing the new mathematical functions for the EVM to ensure that our generalized system is efficient enough for practical use.
4.  **Custom Liquidity Curves**: The ultimate goal of this work is to create a factory that can deploy AMM pools with unique, custom liquidity curves, each defined by a different "metallic mean" derived from your theory.

This is an ambitious but achievable roadmap. The successful completion of Phase 1 has given us a solid foundation to build upon, and we are excited to continue this journey toward a more flexible and powerful future for decentralized finance.
