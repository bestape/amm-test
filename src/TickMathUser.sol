// SPDX-License-Identifier: MIT
pragma solidity ^0.7.6;
pragma abicoder v2;

import {Test} from "forge-std/Test.sol";
import {TickMath} from "v3-core/contracts/libraries/TickMath.sol";

contract TickMathUser is Test {
    function test_getSqrtRatioAtTick() public {
        uint160 sqrtRatio = TickMath.getSqrtRatioAtTick(0);
        assertTrue(sqrtRatio == 79228162514264337593543950336);
    }

    function test_getTickAtSqrtRatio() public {
        uint160 sqrtRatio = 79228162514264337593543950336;
        int24 tick = TickMath.getTickAtSqrtRatio(sqrtRatio);
        assertTrue(tick == 0);
    }
}
