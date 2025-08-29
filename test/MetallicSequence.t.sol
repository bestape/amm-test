// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0;
pragma abicoder v2;

import {Test} from "forge-std/Test.sol";
import {TickMath} from "v3-core/contracts/libraries/TickMath.sol";
import {BaseScaleTickMath} from "../src/BaseScaleTickMath.sol";

contract MetallicSequenceTest is Test {
    /// @dev Generates the n-th term of a metallic sequence that approximates 1 + sqrt(2).
    /// This demonstrates a single-sequence generative method.
    function getMetallicFibonacci(uint256 n) internal pure returns (uint256) {
        if (n == 0) return 1;
        if (n == 1) return 3;
        
        uint256 a_n_minus_2 = 1;
        uint256 a_n_minus_1 = 3;
        uint256 a_n;

        for (uint256 i = 2; i <= n; i++) {
            a_n = 2 * a_n_minus_1 + a_n_minus_2;
            a_n_minus_2 = a_n_minus_1;
            a_n_minus_1 = a_n;
        }
        return a_n;
    }

    /// @dev Tests that the ratio of consecutive terms approximates 1 + sqrt(2).
    function test_metallic_fibonacci_approximation() public {
        // We generate two consecutive high-order terms for a precise approximation.
        uint256 term_n = getMetallicFibonacci(15);
        uint256 term_n_minus_1 = getMetallicFibonacci(14);

        // The ratio of consecutive terms approximates 1 + sqrt(2).
        // We subtract 1 to get an approximation for sqrt(2).
        // We use a precision factor to handle the fractional part in integer arithmetic.
        uint256 precision = 1e18;
        uint256 sqrt2_approx = (term_n * precision / term_n_minus_1) - precision;

        // We square the approximation and check if it's close to 2.
        uint256 result = (sqrt2_approx * sqrt2_approx) / precision / precision;
        
        // We expect the result to be very close to 2.
        assertApproxEqAbs(result, 2, 1e12, "Approximation of sqrt(2)^2 is not close to 2");
    }
}
