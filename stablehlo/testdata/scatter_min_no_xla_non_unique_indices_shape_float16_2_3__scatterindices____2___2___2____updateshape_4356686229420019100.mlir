// RUN-DISABLED: stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt -inline | stablehlo-translate --interpret
// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = stablehlo.constant dense<2> : tensor<1x3x1xi32>
    %1:2 = call @inputs() : () -> (tensor<2x3xf16>, tensor<2x1x3xf16>)
    %2 = call @expected() : () -> tensor<2x3xf16>
    %3 = "stablehlo.scatter"(%1#0, %0, %1#1) ({
    ^bb0(%arg0: tensor<f16>, %arg1: tensor<f16>):
      %5 = stablehlo.minimum %arg0, %arg1 : tensor<f16>
      stablehlo.return %5 : tensor<f16>
    }) {scatter_dimension_numbers = #stablehlo.scatter<update_window_dims = [0], inserted_window_dims = [1], scatter_dims_to_operand_dims = [1], index_vector_dim = 2>} : (tensor<2x3xf16>, tensor<1x3x1xi32>, tensor<2x1x3xf16>) -> tensor<2x3xf16>
    %4 = stablehlo.custom_call @check.eq(%3, %2) : (tensor<2x3xf16>, tensor<2x3xf16>) -> tensor<i1>
    return %4 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<2x3xf16>, tensor<2x1x3xf16>) {
    %0 = stablehlo.constant dense<[[-5.712890e-01, 4.988280e+00, -1.277340e+00], [-8.759760e-01, -6.474610e-01, -2.611330e+00]]> : tensor<2x3xf16>
    %1 = stablehlo.constant dense<[[[-8.364250e-01, -7.191400e+00, 1.938480e-01]], [[-1.790040e+00, -1.565430e+00, -6.316400e+00]]]> : tensor<2x1x3xf16>
    return %0, %1 : tensor<2x3xf16>, tensor<2x1x3xf16>
  }
  func.func private @expected() -> tensor<2x3xf16> {
    %0 = stablehlo.constant dense<[[-5.712890e-01, 4.988280e+00, -7.191400e+00], [-8.759760e-01, -6.474610e-01, -6.316400e+00]]> : tensor<2x3xf16>
    return %0 : tensor<2x3xf16>
  }
}

