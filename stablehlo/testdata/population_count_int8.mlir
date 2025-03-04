// RUN: stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt -inline | stablehlo-translate --interpret
// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = call @inputs() : () -> tensor<4xi8>
    %1 = call @expected() : () -> tensor<4xi8>
    %2 = stablehlo.popcnt %0 : tensor<4xi8>
    %3 = stablehlo.custom_call @check.eq(%2, %1) : (tensor<4xi8>, tensor<4xi8>) -> tensor<i1>
    return %3 : tensor<i1>
  }
  func.func private @inputs() -> tensor<4xi8> {
    %0 = stablehlo.constant dense<[-1, -2, 0, 1]> : tensor<4xi8>
    return %0 : tensor<4xi8>
  }
  func.func private @expected() -> tensor<4xi8> {
    %0 = stablehlo.constant dense<[8, 7, 0, 1]> : tensor<4xi8>
    return %0 : tensor<4xi8>
  }
}
