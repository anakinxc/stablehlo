// RUN: diff <(stablehlo-opt %s --stablehlo-legalize-to-vhlo --vhlo-to-version=target=current -emit-bytecode | stablehlo-opt --vhlo-legalize-to-stablehlo) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = stablehlo.constant dense<[0, 4]> : tensor<2xi32>
    %1:2 = call @inputs() : () -> (tensor<4x2x3x5xui8>, tensor<4x3xui8>)
    %2 = call @expected() : () -> tensor<4x2x3x5xui8>
    %3 = "stablehlo.scatter"(%1#0, %0, %1#1) ({
    ^bb0(%arg0: tensor<ui8>, %arg1: tensor<ui8>):
      stablehlo.return %arg1 : tensor<ui8>
    }) {scatter_dimension_numbers = #stablehlo.scatter<update_window_dims = [0, 1], inserted_window_dims = [1, 3], scatter_dims_to_operand_dims = [1, 3]>, unique_indices = true} : (tensor<4x2x3x5xui8>, tensor<2xi32>, tensor<4x3xui8>) -> tensor<4x2x3x5xui8>
    %4 = stablehlo.custom_call @check.eq(%3, %2) : (tensor<4x2x3x5xui8>, tensor<4x2x3x5xui8>) -> tensor<i1>
    return %4 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<4x2x3x5xui8>, tensor<4x3xui8>) {
    %0 = stablehlo.constant dense<"0x020003030200000000060102020102000003020103000201030101020305020301010505010102000403040307000302000400020000030201030401010100020001030006020002030207020103000004040004060402050402070302020001010108030403000303000001010000050204000004070201"> : tensor<4x2x3x5xui8>
    %1 = stablehlo.constant dense<[[1, 3, 2], [0, 2, 1], [1, 4, 0], [3, 1, 5]]> : tensor<4x3xui8>
    return %0, %1 : tensor<4x2x3x5xui8>, tensor<4x3xui8>
  }
  func.func private @expected() -> tensor<4x2x3x5xui8> {
    %0 = stablehlo.constant dense<"0x020003030100000000030102020102000003020103000201030101020305020301010005010102020403040301000302000400020000030201030401010100020101030006040002030200020103000004040004060402050402070302020301010108010403000305000001010000050204000004070201"> : tensor<4x2x3x5xui8>
    return %0 : tensor<4x2x3x5xui8>
  }
}
