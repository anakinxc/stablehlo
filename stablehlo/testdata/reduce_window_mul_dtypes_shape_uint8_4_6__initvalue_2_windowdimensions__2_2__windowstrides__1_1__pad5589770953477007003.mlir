// RUN: stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt -inline | stablehlo-translate --interpret
// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = call @inputs() : () -> tensor<4x6xui8>
    %1 = call @expected() : () -> tensor<3x5xui8>
    %2 = stablehlo.constant dense<2> : tensor<ui8>
    %3 = "stablehlo.reduce_window"(%0, %2) ({
    ^bb0(%arg0: tensor<ui8>, %arg1: tensor<ui8>):
      %5 = stablehlo.multiply %arg0, %arg1 : tensor<ui8>
      stablehlo.return %5 : tensor<ui8>
    }) {window_dimensions = dense<2> : tensor<2xi64>} : (tensor<4x6xui8>, tensor<ui8>) -> tensor<3x5xui8>
    %4 = stablehlo.custom_call @check.eq(%3, %1) : (tensor<3x5xui8>, tensor<3x5xui8>) -> tensor<i1>
    return %4 : tensor<i1>
  }
  func.func private @inputs() -> tensor<4x6xui8> {
    %0 = stablehlo.constant dense<[[0, 1, 5, 4, 3, 1], [0, 3, 0, 2, 2, 0], [5, 6, 0, 2, 2, 4], [0, 9, 0, 1, 4, 0]]> : tensor<4x6xui8>
    return %0 : tensor<4x6xui8>
  }
  func.func private @expected() -> tensor<3x5xui8> {
    %0 = stablehlo.constant dense<[[0, 0, 0, 96, 0], [0, 0, 0, 32, 0], [0, 0, 0, 32, 0]]> : tensor<3x5xui8>
    return %0 : tensor<3x5xui8>
  }
}

