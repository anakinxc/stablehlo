// RUN: stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt -inline | stablehlo-translate --interpret
// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = call @inputs() : () -> tensor<8x9xi16>
    %1 = call @expected() : () -> tensor<8x9xi16>
    %2 = call @cumsum(%0) : (tensor<8x9xi16>) -> tensor<8x9xi16>
    %3 = stablehlo.custom_call @check.eq(%2, %1) : (tensor<8x9xi16>, tensor<8x9xi16>) -> tensor<i1>
    return %3 : tensor<i1>
  }
  func.func private @inputs() -> tensor<8x9xi16> {
    %0 = stablehlo.constant dense<[[-2, -5, -1, 0, 1, -2, 0, -3, 2], [0, -2, 3, 2, 0, 0, 5, -6, -3], [0, 4, -4, 7, -1, 4, -3, 0, 2], [0, 0, 2, 4, -2, 0, 4, -5, 3], [0, 4, -5, 1, 1, -2, -3, 0, 0], [-3, 0, 0, -2, -2, -2, 2, 1, -3], [0, 1, 0, -4, 0, -2, 3, 0, -2], [4, 4, 0, 5, 2, -2, 0, 0, 0]]> : tensor<8x9xi16>
    return %0 : tensor<8x9xi16>
  }
  func.func private @expected() -> tensor<8x9xi16> {
    %0 = stablehlo.constant dense<[[-2, -5, -1, 0, 1, -2, 0, -3, 2], [-2, -7, 2, 2, 1, -2, 5, -9, -1], [-2, -3, -2, 9, 0, 2, 2, -9, 1], [-2, -3, 0, 13, -2, 2, 6, -14, 4], [-2, 1, -5, 14, -1, 0, 3, -14, 4], [-5, 1, -5, 12, -3, -2, 5, -13, 1], [-5, 2, -5, 8, -3, -4, 8, -13, -1], [-1, 6, -5, 13, -1, -6, 8, -13, -1]]> : tensor<8x9xi16>
    return %0 : tensor<8x9xi16>
  }
  func.func private @cumsum(%arg0: tensor<8x9xi16>) -> tensor<8x9xi16> {
    %0 = "stablehlo.slice"(%arg0) {limit_indices = dense<[7, 9]> : tensor<2xi64>, start_indices = dense<0> : tensor<2xi64>, strides = dense<[2, 1]> : tensor<2xi64>} : (tensor<8x9xi16>) -> tensor<4x9xi16>
    %1 = "stablehlo.slice"(%arg0) {limit_indices = dense<[8, 9]> : tensor<2xi64>, start_indices = dense<[1, 0]> : tensor<2xi64>, strides = dense<[2, 1]> : tensor<2xi64>} : (tensor<8x9xi16>) -> tensor<4x9xi16>
    %2 = stablehlo.add %0, %1 : tensor<4x9xi16>
    %3 = "stablehlo.slice"(%2) {limit_indices = dense<[3, 9]> : tensor<2xi64>, start_indices = dense<0> : tensor<2xi64>, strides = dense<[2, 1]> : tensor<2xi64>} : (tensor<4x9xi16>) -> tensor<2x9xi16>
    %4 = "stablehlo.slice"(%2) {limit_indices = dense<[4, 9]> : tensor<2xi64>, start_indices = dense<[1, 0]> : tensor<2xi64>, strides = dense<[2, 1]> : tensor<2xi64>} : (tensor<4x9xi16>) -> tensor<2x9xi16>
    %5 = stablehlo.add %3, %4 : tensor<2x9xi16>
    %6 = "stablehlo.slice"(%5) {limit_indices = dense<[1, 9]> : tensor<2xi64>, start_indices = dense<0> : tensor<2xi64>, strides = dense<[2, 1]> : tensor<2xi64>} : (tensor<2x9xi16>) -> tensor<1x9xi16>
    %7 = "stablehlo.slice"(%5) {limit_indices = dense<[2, 9]> : tensor<2xi64>, start_indices = dense<[1, 0]> : tensor<2xi64>, strides = dense<[2, 1]> : tensor<2xi64>} : (tensor<2x9xi16>) -> tensor<1x9xi16>
    %8 = stablehlo.add %6, %7 : tensor<1x9xi16>
    %9 = "stablehlo.slice"(%8) {limit_indices = dense<[0, 9]> : tensor<2xi64>, start_indices = dense<0> : tensor<2xi64>, strides = dense<1> : tensor<2xi64>} : (tensor<1x9xi16>) -> tensor<0x9xi16>
    %10 = "stablehlo.slice"(%5) {limit_indices = dense<[2, 9]> : tensor<2xi64>, start_indices = dense<[2, 0]> : tensor<2xi64>, strides = dense<[2, 1]> : tensor<2xi64>} : (tensor<2x9xi16>) -> tensor<0x9xi16>
    %11 = stablehlo.add %9, %10 : tensor<0x9xi16>
    %12 = "stablehlo.slice"(%5) {limit_indices = dense<[1, 9]> : tensor<2xi64>, start_indices = dense<0> : tensor<2xi64>, strides = dense<1> : tensor<2xi64>} : (tensor<2x9xi16>) -> tensor<1x9xi16>
    %13 = stablehlo.concatenate %12, %11, dim = 0 : (tensor<1x9xi16>, tensor<0x9xi16>) -> tensor<1x9xi16>
    %14 = stablehlo.constant dense<0> : tensor<i16>
    %15 = stablehlo.pad %13, %14, low = [0, 0], high = [1, 0], interior = [1, 0] : (tensor<1x9xi16>, tensor<i16>) -> tensor<2x9xi16>
    %16 = stablehlo.constant dense<0> : tensor<i16>
    %17 = stablehlo.pad %8, %16, low = [1, 0], high = [0, 0], interior = [1, 0] : (tensor<1x9xi16>, tensor<i16>) -> tensor<2x9xi16>
    %18 = stablehlo.add %15, %17 : tensor<2x9xi16>
    %19 = "stablehlo.slice"(%18) {limit_indices = dense<[1, 9]> : tensor<2xi64>, start_indices = dense<0> : tensor<2xi64>, strides = dense<1> : tensor<2xi64>} : (tensor<2x9xi16>) -> tensor<1x9xi16>
    %20 = "stablehlo.slice"(%2) {limit_indices = dense<[4, 9]> : tensor<2xi64>, start_indices = dense<[2, 0]> : tensor<2xi64>, strides = dense<[2, 1]> : tensor<2xi64>} : (tensor<4x9xi16>) -> tensor<1x9xi16>
    %21 = stablehlo.add %19, %20 : tensor<1x9xi16>
    %22 = "stablehlo.slice"(%2) {limit_indices = dense<[1, 9]> : tensor<2xi64>, start_indices = dense<0> : tensor<2xi64>, strides = dense<1> : tensor<2xi64>} : (tensor<4x9xi16>) -> tensor<1x9xi16>
    %23 = stablehlo.concatenate %22, %21, dim = 0 : (tensor<1x9xi16>, tensor<1x9xi16>) -> tensor<2x9xi16>
    %24 = stablehlo.constant dense<0> : tensor<i16>
    %25 = stablehlo.pad %23, %24, low = [0, 0], high = [1, 0], interior = [1, 0] : (tensor<2x9xi16>, tensor<i16>) -> tensor<4x9xi16>
    %26 = stablehlo.constant dense<0> : tensor<i16>
    %27 = stablehlo.pad %18, %26, low = [1, 0], high = [0, 0], interior = [1, 0] : (tensor<2x9xi16>, tensor<i16>) -> tensor<4x9xi16>
    %28 = stablehlo.add %25, %27 : tensor<4x9xi16>
    %29 = "stablehlo.slice"(%28) {limit_indices = dense<[3, 9]> : tensor<2xi64>, start_indices = dense<0> : tensor<2xi64>, strides = dense<1> : tensor<2xi64>} : (tensor<4x9xi16>) -> tensor<3x9xi16>
    %30 = "stablehlo.slice"(%arg0) {limit_indices = dense<[8, 9]> : tensor<2xi64>, start_indices = dense<[2, 0]> : tensor<2xi64>, strides = dense<[2, 1]> : tensor<2xi64>} : (tensor<8x9xi16>) -> tensor<3x9xi16>
    %31 = stablehlo.add %29, %30 : tensor<3x9xi16>
    %32 = "stablehlo.slice"(%arg0) {limit_indices = dense<[1, 9]> : tensor<2xi64>, start_indices = dense<0> : tensor<2xi64>, strides = dense<1> : tensor<2xi64>} : (tensor<8x9xi16>) -> tensor<1x9xi16>
    %33 = stablehlo.concatenate %32, %31, dim = 0 : (tensor<1x9xi16>, tensor<3x9xi16>) -> tensor<4x9xi16>
    %34 = stablehlo.constant dense<0> : tensor<i16>
    %35 = stablehlo.pad %33, %34, low = [0, 0], high = [1, 0], interior = [1, 0] : (tensor<4x9xi16>, tensor<i16>) -> tensor<8x9xi16>
    %36 = stablehlo.constant dense<0> : tensor<i16>
    %37 = stablehlo.pad %28, %36, low = [1, 0], high = [0, 0], interior = [1, 0] : (tensor<4x9xi16>, tensor<i16>) -> tensor<8x9xi16>
    %38 = stablehlo.add %35, %37 : tensor<8x9xi16>
    return %38 : tensor<8x9xi16>
  }
}
