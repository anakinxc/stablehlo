// RUN: diff <(stablehlo-opt %s --stablehlo-legalize-to-vhlo --vhlo-to-version=target=current -emit-bytecode | stablehlo-opt --vhlo-legalize-to-stablehlo) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = call @inputs() : () -> tensor<2x3xi32>
    %1 = call @expected() : () -> tensor<2x3xi32>
    %2 = stablehlo.bitcast_convert %0 : (tensor<2x3xi32>) -> tensor<2x3xi32>
    %3 = stablehlo.custom_call @check.eq(%2, %1) : (tensor<2x3xi32>, tensor<2x3xi32>) -> tensor<i1>
    return %3 : tensor<i1>
  }
  func.func private @inputs() -> tensor<2x3xi32> {
    %0 = stablehlo.constant dense<[[2, 0, 0], [-4, 0, 0]]> : tensor<2x3xi32>
    return %0 : tensor<2x3xi32>
  }
  func.func private @expected() -> tensor<2x3xi32> {
    %0 = stablehlo.constant dense<[[2, 0, 0], [-4, 0, 0]]> : tensor<2x3xi32>
    return %0 : tensor<2x3xi32>
  }
}