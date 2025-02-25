// RUN-DISABLED: stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt -inline | stablehlo-translate --interpret
// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = stablehlo.constant dense<32> : tensor<1xi32>
    %1:2 = call @inputs() : () -> (tensor<1x50x3xi8>, tensor<1x3xi8>)
    %2 = call @expected() : () -> tensor<1x50x3xi8>
    %3 = "stablehlo.scatter"(%1#0, %0, %1#1) ({
    ^bb0(%arg0: tensor<i8>, %arg1: tensor<i8>):
      %5 = stablehlo.add %arg0, %arg1 : tensor<i8>
      stablehlo.return %5 : tensor<i8>
    }) {scatter_dimension_numbers = #stablehlo.scatter<update_window_dims = [0, 1], inserted_window_dims = [1], scatter_dims_to_operand_dims = [1]>, unique_indices = true} : (tensor<1x50x3xi8>, tensor<1xi32>, tensor<1x3xi8>) -> tensor<1x50x3xi8>
    %4 = stablehlo.custom_call @check.eq(%3, %2) : (tensor<1x50x3xi8>, tensor<1x50x3xi8>) -> tensor<i1>
    return %4 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<1x50x3xi8>, tensor<1x3xi8>) {
    %0 = stablehlo.constant dense<"0x02FC0400FCFE0200FF0604000005FE04FFFDFF02FD00FE0202FEFFFFF8FD000002FE0000FA00FFFD00FE0000FBFEFC05FF00FAFF00FDFF020100FF010200FF00FFFCFE00FFFEFF00FFFF0301FB030200030400FE01FFFC03030403030100FE01FEFD03FE02FC03FFFD0000FEFE0700000300FBFFFE00020206FE02FD0101FE00FCFC01FF00FF010200FC0201FD0201010000FFFE0300"> : tensor<1x50x3xi8>
    %1 = stablehlo.constant dense<[[1, 0, 1]]> : tensor<1x3xi8>
    return %0, %1 : tensor<1x50x3xi8>, tensor<1x3xi8>
  }
  func.func private @expected() -> tensor<1x50x3xi8> {
    %0 = stablehlo.constant dense<"0x02FC0400FCFE0200FF0604000005FE04FFFDFF02FD00FE0202FEFFFFF8FD000002FE0000FA00FFFD00FE0000FBFEFC05FF00FAFF00FDFF020100FF010200FF00FFFCFE00FFFEFF00FFFF0301FB030200030400FE01FFFC03030403030100FE01FFFD04FE02FC03FFFD0000FEFE0700000300FBFFFE00020206FE02FD0101FE00FCFC01FF00FF010200FC0201FD0201010000FFFE0300"> : tensor<1x50x3xi8>
    return %0 : tensor<1x50x3xi8>
  }
}

