// RUN-DISABLED: stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt -inline | stablehlo-translate --interpret
// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0:2 = call @inputs() : () -> (tensor<7x3x4xui32>, tensor<7x4xui32>)
    %1 = call @expected() : () -> tensor<7x3xui32>
    %2 = "stablehlo.dot_general"(%0#0, %0#1) {dot_dimension_numbers = #stablehlo.dot<lhs_batching_dimensions = [0], rhs_batching_dimensions = [0], lhs_contracting_dimensions = [2], rhs_contracting_dimensions = [1]>, precision_config = [#stablehlo<precision HIGHEST>, #stablehlo<precision HIGHEST>]} : (tensor<7x3x4xui32>, tensor<7x4xui32>) -> tensor<7x3xui32>
    %3 = stablehlo.custom_call @check.eq(%2, %1) : (tensor<7x3xui32>, tensor<7x3xui32>) -> tensor<i1>
    return %3 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<7x3x4xui32>, tensor<7x4xui32>) {
    %0 = stablehlo.constant dense<[[[0, 0, 2, 0], [2, 3, 3, 3], [0, 2, 3, 1]], [[3, 3, 6, 2], [1, 0, 2, 3], [1, 2, 2, 0]], [[5, 4, 6, 2], [2, 0, 0, 1], [3, 2, 3, 4]], [[2, 0, 3, 4], [3, 0, 3, 1], [1, 0, 0, 0]], [[3, 2, 3, 2], [3, 1, 0, 4], [4, 1, 0, 3]], [[0, 1, 0, 0], [0, 2, 2, 2], [0, 0, 6, 2]], [[1, 2, 0, 3], [1, 5, 0, 0], [2, 1, 1, 1]]]> : tensor<7x3x4xui32>
    %1 = stablehlo.constant dense<[[5, 2, 2, 2], [1, 0, 3, 3], [0, 0, 1, 0], [0, 0, 2, 4], [2, 1, 1, 0], [0, 7, 0, 3], [0, 0, 5, 0]]> : tensor<7x4xui32>
    return %0, %1 : tensor<7x3x4xui32>, tensor<7x4xui32>
  }
  func.func private @expected() -> tensor<7x3xui32> {
    %0 = stablehlo.constant dense<[[4, 28, 12], [27, 16, 7], [6, 0, 3], [22, 10, 0], [11, 7, 9], [7, 20, 6], [0, 0, 5]]> : tensor<7x3xui32>
    return %0 : tensor<7x3xui32>
  }
}
