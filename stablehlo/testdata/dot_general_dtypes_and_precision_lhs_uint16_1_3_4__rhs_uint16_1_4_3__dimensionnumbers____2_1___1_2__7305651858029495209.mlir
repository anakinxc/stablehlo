// RUN-DISABLED: stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt -inline | stablehlo-translate --interpret
// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0:2 = call @inputs() : () -> (tensor<1x3x4xui16>, tensor<1x4x3xui16>)
    %1 = call @expected() : () -> tensor<1xui16>
    %2 = "stablehlo.dot_general"(%0#0, %0#1) {dot_dimension_numbers = #stablehlo.dot<lhs_batching_dimensions = [0], rhs_batching_dimensions = [0], lhs_contracting_dimensions = [2, 1], rhs_contracting_dimensions = [1, 2]>, precision_config = [#stablehlo<precision HIGHEST>, #stablehlo<precision HIGHEST>]} : (tensor<1x3x4xui16>, tensor<1x4x3xui16>) -> tensor<1xui16>
    %3 = stablehlo.custom_call @check.eq(%2, %1) : (tensor<1xui16>, tensor<1xui16>) -> tensor<i1>
    return %3 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<1x3x4xui16>, tensor<1x4x3xui16>) {
    %0 = stablehlo.constant dense<[[[0, 1, 2, 2], [3, 3, 2, 1], [1, 6, 2, 1]]]> : tensor<1x3x4xui16>
    %1 = stablehlo.constant dense<[[[2, 4, 6], [1, 3, 1], [2, 1, 1], [1, 0, 0]]]> : tensor<1x4x3xui16>
    return %0, %1 : tensor<1x3x4xui16>, tensor<1x4x3xui16>
  }
  func.func private @expected() -> tensor<1xui16> {
    %0 = stablehlo.constant dense<44> : tensor<1xui16>
    return %0 : tensor<1xui16>
  }
}
