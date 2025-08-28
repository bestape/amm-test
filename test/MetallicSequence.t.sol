// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0;
pragma abicoder v2;

import {Test} from "forge-std/Test.sol";
import {TickMath} from "v3-core/contracts/libraries/TickMath.sol";
import {BaseScaleTickMath} from "../src/BaseScaleTickMath.sol";

contract MetallicSequenceTest is Test {
    /// @dev Generates the numerator and denominator for the n-th convergent of sqrt(2).
    /// This demonstrates the generative method for a known metallic mean.
    /// Numerators are the Pell-Lucas numbers (A001333), and denominators are the Pell numbers (A000129).
    /// Both sequences follow the recurrence x(n) = 2*x(n-1) + x(n-2).
    function getSqrt2Approximation(uint256 n) internal pure returns (uint256 numerator, uint256 denominator) {
        if (n == 0) return (1, 1);

        uint256 p_minus_2 = 1; // p(0)
        uint256 p_minus_1 = 3; // p(1)

        uint256 q_minus_2 = 1; // q(0)
        uint256 q_minus_1 = 2; // q(1)

        if (n == 1) return (p_minus_1, q_minus_1);

        uint256 p_n;
        uint256 q_n;

        for (uint256 i = 2; i <= n; i++) {
            p_n = 2 * p_minus_1 + p_minus_2;
            q_n = 2 * q_minus_1 + q_minus_2;
            
            p_minus_2 = p_minus_1;
            p_minus_1 = p_n;
            
            q_minus_2 = q_minus_1;
            q_minus_1 = q_n;
        }
        return (p_n, q_n);
    }

    /// @dev Tests that the generated fraction for sqrt(2) satisfies Pell's equation.
    function test_sqrt2_approximation() public {
        // We generate a high-order convergent for a precise approximation.
        (uint256 numerator, uint256 denominator) = getSqrt2Approximation(15);

        // The convergents of sqrt(2) are known to satisfy the Pell's equation x^2 - 2y^2 = ±1.
        // This provides a perfect, integer-based way to validate our generative method.
        int256 result = int256(numerator * numerator) - 2 * int256(denominator * denominator);
        
        assertTrue(result == 1 || result == -1, "Pell's equation not satisfied");
    }
}
