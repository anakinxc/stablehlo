// RUN-DISABLED: stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt -inline | stablehlo-translate --interpret
// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = stablehlo.constant dense<[[[0, 1], [2, 3]], [[4, 0], [1, 2]]]> : tensor<2x2x2xi32>
    %1:2 = call @inputs() : () -> (tensor<5x6x7xi32>, tensor<5x2x2xi32>)
    %2 = call @expected() : () -> tensor<5x6x7xi32>
    %3 = "stablehlo.scatter"(%1#0, %0, %1#1) ({
    ^bb0(%arg0: tensor<i32>, %arg1: tensor<i32>):
      %5 = stablehlo.multiply %arg0, %arg1 : tensor<i32>
      stablehlo.return %5 : tensor<i32>
    }) {scatter_dimension_numbers = #stablehlo.scatter<update_window_dims = [0], inserted_window_dims = [1, 2], scatter_dims_to_operand_dims = [1, 2], index_vector_dim = 2>, unique_indices = true} : (tensor<5x6x7xi32>, tensor<2x2x2xi32>, tensor<5x2x2xi32>) -> tensor<5x6x7xi32>
    %4 = stablehlo.custom_call @check.eq(%3, %2) : (tensor<5x6x7xi32>, tensor<5x6x7xi32>) -> tensor<i1>
    return %4 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<5x6x7xi32>, tensor<5x2x2xi32>) {
    %0 = stablehlo.constant dense<"0xFEFFFFFFFDFFFFFFFCFFFFFF0600000001000000FEFFFFFF01000000FDFFFFFFFFFFFFFF03000000FFFFFFFF060000000300000001000000FFFFFFFF00000000FFFFFFFF00000000FBFFFFFFFEFFFFFFFFFFFFFFFBFFFFFF0000000002000000FEFFFFFF0000000000000000FFFFFFFF00000000FEFFFFFFFAFFFFFF020000000200000000000000F7FFFFFFFEFFFFFF01000000FEFFFFFF07000000000000000100000003000000FCFFFFFF0000000006000000030000000200000000000000FCFFFFFF040000000200000003000000FBFFFFFF00000000020000000200000003000000FCFFFFFFF9FFFFFFFDFFFFFFFFFFFFFF0000000000000000FFFFFFFFFFFFFFFF0500000003000000FEFFFFFFFEFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFF000000000000000001000000FEFFFFFF00000000FEFFFFFF0000000002000000FFFFFFFF03000000FEFFFFFF00000000FEFFFFFFFDFFFFFFFFFFFFFFFDFFFFFFFFFFFFFF03000000010000000000000000000000FCFFFFFF01000000FDFFFFFF0000000003000000FBFFFFFF0100000006000000FDFFFFFF01000000FDFFFFFF02000000FEFFFFFFFEFFFFFFFEFFFFFFFEFFFFFFFFFFFFFF03000000FDFFFFFFFCFFFFFF0100000004000000FFFFFFFF020000000400000000000000FBFFFFFF000000000100000000000000FEFFFFFF0000000000000000FFFFFFFFFEFFFFFF0000000000000000FDFFFFFF06000000000000000100000001000000FDFFFFFFFFFFFFFF0700000000000000FBFFFFFF00000000FCFFFFFFFFFFFFFFFFFFFFFFFDFFFFFF0200000001000000FEFFFFFFFEFFFFFF01000000030000000000000000000000FDFFFFFF02000000FEFFFFFF0400000000000000FBFFFFFF00000000010000000100000000000000FFFFFFFF0500000000000000030000000000000003000000FCFFFFFF00000000FFFFFFFF01000000FEFFFFFF040000000000000002000000010000000100000001000000FFFFFFFFFCFFFFFF00000000010000000000000003000000FFFFFFFFFDFFFFFF05000000FDFFFFFF000000000000000000000000FDFFFFFFFEFFFFFFFFFFFFFF0000000002000000FCFFFFFFFEFFFFFF0300000000000000020000000100000000000000FFFFFFFFFDFFFFFF02000000"> : tensor<5x6x7xi32>
    %1 = stablehlo.constant dense<[[[0, 0], [1, -6]], [[2, 0], [-1, 3]], [[0, -6], [5, -3]], [[0, -1], [-1, -4]], [[-4, -1], [0, 2]]]> : tensor<5x2x2xi32>
    return %0, %1 : tensor<5x6x7xi32>, tensor<5x2x2xi32>
  }
  func.func private @expected() -> tensor<5x6x7xi32> {
    %0 = stablehlo.constant dense<"0xFEFFFFFF00000000FCFFFFFF0600000001000000FEFFFFFF01000000FDFFFFFFFFFFFFFFEEFFFFFFFFFFFFFF060000000300000001000000FFFFFFFF00000000FFFFFFFF00000000FBFFFFFFFEFFFFFFFFFFFFFFFBFFFFFF0000000002000000FEFFFFFF0000000000000000FFFFFFFF00000000FEFFFFFFFAFFFFFF020000000200000000000000F7FFFFFFFEFFFFFF01000000FEFFFFFF07000000000000000100000003000000FCFFFFFF0000000006000000030000000200000000000000FCFFFFFF040000000200000009000000FBFFFFFF00000000020000000200000003000000FCFFFFFFF9FFFFFF00000000FFFFFFFF0000000000000000FFFFFFFFFFFFFFFF0500000003000000FEFFFFFFFEFFFFFFFEFFFFFF01000000FFFFFFFFFEFFFFFFFEFFFFFF000000000000000001000000FEFFFFFF00000000FEFFFFFF0000000002000000FFFFFFFF03000000FEFFFFFF00000000FEFFFFFFFDFFFFFFFFFFFFFFFDFFFFFFFFFFFFFF03000000010000000000000000000000FCFFFFFF01000000FDFFFFFF0000000003000000FBFFFFFFFAFFFFFF06000000FDFFFFFF01000000FDFFFFFF02000000FEFFFFFFFEFFFFFFFEFFFFFFFEFFFFFFFFFFFFFF0F000000FDFFFFFFFCFFFFFF0100000004000000FFFFFFFF020000000400000000000000FBFFFFFF000000000100000000000000FEFFFFFF0000000000000000FFFFFFFFFEFFFFFF0000000000000000FDFFFFFF0600000000000000FCFFFFFF01000000FDFFFFFFFFFFFFFF0700000000000000FBFFFFFF0000000004000000FFFFFFFFFFFFFFFFFDFFFFFF0200000001000000FEFFFFFFFEFFFFFF01000000030000000000000000000000FDFFFFFF02000000FEFFFFFF0400000000000000FBFFFFFF00000000010000000100000000000000FFFFFFFF0500000000000000030000000000000003000000FCFFFFFF00000000FFFFFFFF01000000FEFFFFFF040000000000000002000000010000000100000001000000FFFFFFFFFCFFFFFF00000000FFFFFFFF0000000003000000FFFFFFFFFDFFFFFF05000000FDFFFFFF000000000000000000000000FDFFFFFF00000000FFFFFFFF0000000002000000FCFFFFFFFEFFFFFF0300000000000000020000000100000000000000FFFFFFFFFDFFFFFF02000000"> : tensor<5x6x7xi32>
    return %0 : tensor<5x6x7xi32>
  }
}

