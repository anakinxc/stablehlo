// RUN: diff <(stablehlo-opt %s --stablehlo-legalize-to-vhlo --vhlo-to-version=target=current -emit-bytecode | stablehlo-opt --vhlo-legalize-to-stablehlo) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0:2 = call @inputs() : () -> (tensor<20x20xi16>, tensor<20x20xi16>)
    %1 = call @expected() : () -> tensor<20x20xi16>
    %2 = stablehlo.multiply %0#0, %0#1 : tensor<20x20xi16>
    %3 = stablehlo.custom_call @check.eq(%2, %1) : (tensor<20x20xi16>, tensor<20x20xi16>) -> tensor<i1>
    return %3 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<20x20xi16>, tensor<20x20xi16>) {
    %0 = stablehlo.constant dense<"0xFFFFFCFF00000000FCFF0100020001000200FEFFFDFF000001000000FDFF0300FEFFFDFF00000100FCFF0500FDFF00000000F7FF0300000000000100FBFFFFFFFCFF0000FCFF02000100FDFFFBFF0000FFFFFEFFFEFF05000000FDFF03000000FCFF0400FFFFFEFF000000000100FEFF030000000000FCFF0500020001000200020001000000FFFFFEFFFFFF0100020001000000000003000000010000000400FEFF00000000000003000000FEFF01000000FFFF00000400FCFF02000300FFFFFEFF04000000FFFF0200FFFF0600FFFF010004000400FEFF070005000800000002000000FEFF00000100FAFFFBFFFDFF06000200010005000300FEFFFEFF0000FDFF000001000200FEFFFFFFFFFFFFFF02000300FEFFFAFFFDFF0000FDFFFDFFFFFF0200010000000000FBFF010002000000FAFF00000100FDFF0000FEFF03000200FEFFFFFF010001000000FAFF0000FFFF0000FDFF0000FDFF000002000000FFFF01000000FFFFFBFF0300FEFFFFFF000003000100FDFF0200FEFFFFFF0300000003000500FCFF0000030003000200020000000000FEFF0000FEFFFDFFFDFF0100020002000400FDFFFCFF0000FEFF000000000000000000000200FFFFFEFFFAFF040000000400FEFF0000FDFF02000000FFFF030000000000FFFF0A000500FEFF0000FCFF0200FFFFFFFFFDFF0400FBFFFFFF02000000FDFFFEFF050001000300FEFFFEFF0000FCFF03000000000000000300000000000600FCFFFCFF010001000100FEFFFFFFFDFF00000000030002000000FEFF00000500FEFFFEFFFDFFFFFF03000200FFFFFFFF0000040001000000FFFFFEFF0000FEFF000000000100FFFF0000000000000000020001000100010000000700FDFF01000100FFFFFDFFFFFF04000400FFFF0100FEFF01000200FEFF02000100FCFF0100FCFF000000000300FFFF05000200FEFF01000000FCFF00000000FCFFFFFFFFFFFCFF04000100010000000000FDFF02000100FFFF00000100FFFFFEFF00000100FEFFFEFF0100FFFF03000000FEFF0300FFFF010006000100FCFF0000FFFF02000000FEFFFCFF0500000001000000FEFF0100FFFFFCFFFAFFFEFF0200FEFF05000000FEFFFFFF"> : tensor<20x20xi16>
    %1 = stablehlo.constant dense<"0x0100FDFF0100FEFF0100010004000200FBFFFFFF040000000100FFFFFFFF00000100FDFF0200FCFF000001000100FFFF04000200000001000100F9FF0000FEFF0100FEFFFDFF06000000FDFFFBFFFDFF020000000100FDFF0000000000000000020000000000000000000500FEFFFEFF01000100FCFFFDFF0200FBFF02000000FDFFFDFF020000000200FBFF0500000000000200000001000300FFFF0600FFFF00000200000001000400000001000000FBFF00000000FEFFFEFF000003000200030000000100FDFFFFFF02000000FFFFFCFFFCFF0200000000000000FEFF0000FBFF0000010001000600FEFFFBFF0000FCFF00000000FEFFFDFF000000000000FFFF010001000000040000000400FEFF000000000000FFFF020000000000FFFFFEFFFDFF00000000020000000000050000000100010000000400FEFF01000400FBFF00000000FCFFFBFFFCFF0200FBFFFEFF0000FFFFFFFF0000FEFFFDFFFFFFFBFF0100FFFFFBFF0500FEFFFCFF0000000003000000040004000200FEFF0000010003000100FFFF00000000FCFF01000000FDFF010000000200000000000400FCFFFFFFFDFF0300020000000000010002000100FDFFFFFFFCFFFEFFFFFF00000000FCFF0200050000000100FDFF00000300020000000000000003000200000005000200FEFFF9FF0000030002000200FEFF0600FFFF0000FAFF0400000000000200020000000000FEFFFEFFFEFFFEFFFEFF00000000FCFF0500FDFFFFFFFCFFFDFFFDFFFFFF0100FCFFFEFFFBFF02000300FFFFFDFF0300FFFFFCFFFFFFFEFF0200FFFFFFFF0600FCFF0200FFFFFCFFFBFFFFFFFFFF02000300FEFF0300FFFFFEFFFFFFFDFF0200FEFFFFFF05000100FFFF0100FCFF0100FFFF00000500FBFFFFFF0000FEFF0000000005000000FEFF00000000FFFF01000000FFFF0200000004000000FCFF00000000FFFF040003000300FFFF03000000000003000000020000000400FDFF0600FBFFFFFF0300FDFF0000FBFF0000010001000000000000000000050001000100FEFFFAFF020004000400FBFF010000000500FFFF0000FEFFFDFF0000000000000100FAFF0100000005000100FCFF010000000200FFFF0000"> : tensor<20x20xi16>
    return %0, %1 : tensor<20x20xi16>, tensor<20x20xi16>
  }
  func.func private @expected() -> tensor<20x20xi16> {
    %0 = stablehlo.constant dense<"0xFFFF0C0000000000FCFF010008000200F6FF0200F4FF00000100000003000000FEFF09000000FCFF00000500FDFF00000000EEFF000000000000F9FF00000200FCFF00000C000C000000090019000000FEFF0000FEFFF1FF0000000000000000F8FF00000000000000000000FEFF04000300000000000C000A00F6FF02000000FAFFFDFF00000000FCFF05000500000000000000000003000000FFFF0000FCFF00000000000000000C000000FEFF0000000000000000F8FF080000000900FEFFFAFF000000000300FEFFFEFF00000100FCFFF0FF0800000000000000F0FF0000F6FF0000FEFF000006000C0019000000E8FF00000000F6FFF7FF0000000000000300000001000000F8FF0000FCFF02000000000000000600FAFF0000000003000200FAFF000000000000000000000A000000FAFF00000000F4FF0000FEFF0C00F6FF00000000FCFFFBFF0000F4FF0000020000000300000000000000FAFF00000500010000000500E7FFFAFF08000000000009000000F4FF0800FCFF02000000000009000500040000000000F4FF02000000000000000000000000000000F4FFFCFFFEFFFAFF0C00FAFF00000000FEFF00000000000000000000FCFF010000000000F0FF0000140000000000090000000000FEFF000000000000FDFF14000000F6FF00000800F2FF0000FDFFFAFF08000A00FAFFFEFF00001200F8FF000000000600FCFF000000000800FAFF0000000000000000000000001E000C000400FCFFFDFFFDFF0200FFFF0C000000000006000600000006000000FBFF080002000600FEFFFDFFFEFFFAFF04000000FCFFFCFF0000010002000000FAFF00000000FFFF02000000000000000000FEFF05000100FFFF0000E4FFFDFFFFFF0000FBFF0F0001000000F8FF00000000F6FF0000FCFF00000000FFFFFCFF00000400000000000C000000ECFF00000000FFFF0000F4FF00000000F4FF00000000F4FF00000200000000000000EEFFF6FFFFFFFDFF00000000050000000000010000000000000000000F000000FEFFFAFF06000200180004001400000000000A00000000000800F1FF000000000000FEFFFAFFFFFF0000E2FFFEFFF8FFFEFF0000000002000000"> : tensor<20x20xi16>
    return %0 : tensor<20x20xi16>
  }
}