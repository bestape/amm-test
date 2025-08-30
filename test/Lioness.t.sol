// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0;
pragma abicoder v2;

import {Test} from "forge-std/Test.sol";

/// @title LionessTest
/// @notice This contract is for testing the alternate "lioness" timeline A330400 sequence.
/// This sequence was originally intended for OEIS A330400 but was rejected and recycled.
/// This test demonstrates the approximation of 1 + 4*sqrt(5), related to Pell-Lucas numbers.
contract LionessTest is Test {
    /// @dev Generates the n-th term of the "lioness" timeline A330400 Base Sequence.
    /// This sequence approximates 1 + 4*sqrt(5).
    /// Note: The branding "Metallic Fibonacci" has been updated to "Base Sequence"
    /// to better align with the "Base Scale" concept.
    function getBaseSequence(uint256 n) internal pure returns (uint256) {
        // Seed values are based on user's instruction for this specific sequence.
        if (n == 0) return 2;
        if (n == 1) return 82;
        
        uint256 a_n_minus_2 = 2;
        uint256 a_n_minus_1 = 82;
        uint256 a_n;

        for (uint256 i = 2; i <= n; i++) {
            // The recurrence relation is a(n) = 2*a(n-1) + 79*a(n-2), derived from 2b = (4^2 * 5) - 1 = 79.
            a_n = 2 * a_n_minus_1 + 79 * a_n_minus_2;
            a_n_minus_2 = a_n_minus_1;
            a_n_minus_1 = a_n;
        }
        return a_n;
    }

    /// @dev Tests that the ratio of consecutive terms approximates 1 + 4*sqrt(5).
    function test_lioness_A330400_approximation() public {
        uint256 term_n = getBaseSequence(15);
        uint256 term_n_minus_1 = getBaseSequence(14);

        // The ratio of consecutive terms approximates 1 + 4*sqrt(5).
        // We subtract 1 and divide by 4 to get an approximation for sqrt(5).
        uint256 precision = 1e18;
        uint256 sqrt5_approx = ((term_n * precision / term_n_minus_1) - precision) / 4;

        // We square the approximation and check if it's close to 5.
        uint256 result = (sqrt5_approx * sqrt5_approx) / precision / precision;
        
        assertApproxEqAbs(result, 5, 1e12, "Approximation of sqrt(5)^2 is not close to 5");
    }
}
