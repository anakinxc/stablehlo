// RUN: diff <(stablehlo-opt %s --stablehlo-legalize-to-vhlo --vhlo-to-version=target=current -emit-bytecode | stablehlo-opt --vhlo-legalize-to-stablehlo) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = stablehlo.constant dense<[[0], [2]]> : tensor<2x1xi32>
    %1:2 = call @inputs() : () -> (tensor<5xf32>, tensor<2xf32>)
    %2 = call @expected() : () -> tensor<5xf32>
    %3 = "stablehlo.scatter"(%1#0, %0, %1#1) ({
    ^bb0(%arg0: tensor<f32>, %arg1: tensor<f32>):
      %5 = stablehlo.minimum %arg0, %arg1 : tensor<f32>
      stablehlo.return %5 : tensor<f32>
    }) {scatter_dimension_numbers = #stablehlo.scatter<inserted_window_dims = [0], scatter_dims_to_operand_dims = [0], index_vector_dim = 1>} : (tensor<5xf32>, tensor<2x1xi32>, tensor<2xf32>) -> tensor<5xf32>
    %4 = stablehlo.custom_call @check.eq(%3, %2) : (tensor<5xf32>, tensor<5xf32>) -> tensor<i1>
    return %4 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<5xf32>, tensor<2xf32>) {
    %0 = stablehlo.constant dense<[0.269327819, -1.94162822, 2.71688461, 3.1371398, 1.29206944]> : tensor<5xf32>
    %1 = stablehlo.constant dense<[-0.131836906, -0.483571768]> : tensor<2xf32>
    return %0, %1 : tensor<5xf32>, tensor<2xf32>
  }
  func.func private @expected() -> tensor<5xf32> {
    %0 = stablehlo.constant dense<[-0.131836906, -1.94162822, -0.483571768, 3.1371398, 1.29206944]> : tensor<5xf32>
    return %0 : tensor<5xf32>
  }
}
