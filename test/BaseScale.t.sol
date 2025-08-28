// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0;
pragma abicoder v2;

import {Test} from "forge-std/Test.sol";
import {TickMath} from "v3-core/contracts/libraries/TickMath.sol";
import {BaseScaleTickMath} from "../src/BaseScaleTickMath.sol";

contract BaseScaleValidationTest is Test {
    function test_compareGetSqrtRatioAtTick() public {
        // Test at tick 0
        uint160 expectedSqrtRatio0 = TickMath.getSqrtRatioAtTick(0);
        uint160 actualSqrtRatio0 = BaseScaleTickMath.getSqrtRatioAtTick(0);
        assertEq(uint256(expectedSqrtRatio0), uint256(actualSqrtRatio0), "Mismatch at tick 0");

        // Test at a positive tick
        int24 positiveTick = 10000;
        uint160 expectedSqrtRatioPos = TickMath.getSqrtRatioAtTick(positiveTick);
        uint160 actualSqrtRatioPos = BaseScaleTickMath.getSqrtRatioAtTick(positiveTick);
        assertEq(uint256(expectedSqrtRatioPos), uint256(actualSqrtRatioPos), "Mismatch at positive tick");

        // Test at a negative tick
        int24 negativeTick = -10000;
        uint160 expectedSqrtRatioNeg = TickMath.getSqrtRatioAtTick(negativeTick);
        uint160 actualSqrtRatioNeg = BaseScaleTickMath.getSqrtRatioAtTick(negativeTick);
        assertEq(uint256(expectedSqrtRatioNeg), uint256(actualSqrtRatioNeg), "Mismatch at negative tick");

        // Test at MAX_TICK
        uint160 expectedSqrtRatioMax = TickMath.getSqrtRatioAtTick(TickMath.MAX_TICK);
        uint160 actualSqrtRatioMax = BaseScaleTickMath.getSqrtRatioAtTick(BaseScaleTickMath.MAX_TICK);
        assertEq(uint256(expectedSqrtRatioMax), uint256(actualSqrtRatioMax), "Mismatch at MAX_TICK");

        // Test at MIN_TICK
        uint160 expectedSqrtRatioMin = TickMath.getSqrtRatioAtTick(TickMath.MIN_TICK);
        uint160 actualSqrtRatioMin = BaseScaleTickMath.getSqrtRatioAtTick(BaseScaleTickMath.MIN_TICK);
        assertEq(uint256(expectedSqrtRatioMin), uint256(actualSqrtRatioMin), "Mismatch at MIN_TICK");
    }

    function test_compareGetTickAtSqrtRatio() public {
        // Test at sqrt ratio for tick 0
        uint160 sqrtRatio0 = TickMath.getSqrtRatioAtTick(0);
        int24 expectedTick0 = TickMath.getTickAtSqrtRatio(sqrtRatio0);
        int24 actualTick0 = BaseScaleTickMath.getTickAtSqrtRatio(sqrtRatio0);
        assertEq(int256(expectedTick0), int256(actualTick0), "Mismatch at sqrt ratio for tick 0");

        // Test at a sqrt ratio for a positive tick
        uint160 sqrtRatioPos = TickMath.getSqrtRatioAtTick(25000);
        int24 expectedTickPos = TickMath.getTickAtSqrtRatio(sqrtRatioPos);
        int24 actualTickPos = BaseScaleTickMath.getTickAtSqrtRatio(sqrtRatioPos);
        assertEq(int256(expectedTickPos), int256(actualTickPos), "Mismatch at sqrt ratio for positive tick");

        // Test at a sqrt ratio for a negative tick
        uint160 sqrtRatioNeg = TickMath.getSqrtRatioAtTick(-25000);
        int24 expectedTickNeg = TickMath.getTickAtSqrtRatio(sqrtRatioNeg);
        int24 actualTickNeg = BaseScaleTickMath.getTickAtSqrtRatio(sqrtRatioNeg);
        assertEq(int256(expectedTickNeg), int256(actualTickNeg), "Mismatch at sqrt ratio for negative tick");

        // Test at MIN_SQRT_RATIO
        int24 expectedTickMin = TickMath.getTickAtSqrtRatio(TickMath.MIN_SQRT_RATIO);
        int24 actualTickMin = BaseScaleTickMath.getTickAtSqrtRatio(BaseScaleTickMath.MIN_SQRT_RATIO);
        assertEq(int256(expectedTickMin), int256(actualTickMin), "Mismatch at MIN_SQRT_RATIO");
    }
}
