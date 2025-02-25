// RUN: stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt -inline | stablehlo-translate --interpret
// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = call @inputs() : () -> tensor<15xf32>
    %1 = call @expected() : () -> tensor<i8>
    %2 = call @argmax(%0) : (tensor<15xf32>) -> tensor<i8>
    %3 = stablehlo.custom_call @check.eq(%2, %1) : (tensor<i8>, tensor<i8>) -> tensor<i1>
    return %3 : tensor<i1>
  }
  func.func private @inputs() -> tensor<15xf32> {
    %0 = stablehlo.constant dense<[-0.451623648, 1.7385205, -4.82047176, 1.3215971, 2.03249788, 2.78954458, -0.898379087, 0.0791557431, 0.325090945, 0.0615171269, 0.962290704, 2.26002383, 4.04935551, -2.45957828, -4.00314903]> : tensor<15xf32>
    return %0 : tensor<15xf32>
  }
  func.func private @expected() -> tensor<i8> {
    %0 = stablehlo.constant dense<12> : tensor<i8>
    return %0 : tensor<i8>
  }
  func.func private @argmax(%arg0: tensor<15xf32>) -> tensor<i8> {
    %0 = stablehlo.iota dim = 0 : tensor<15xi8>
    %1 = stablehlo.constant dense<0xFF800000> : tensor<f32>
    %2 = stablehlo.constant dense<0> : tensor<i8>
    %3:2 = stablehlo.reduce(%arg0 init: %1), (%0 init: %2) across dimensions = [0] : (tensor<15xf32>, tensor<15xi8>, tensor<f32>, tensor<i8>) -> (tensor<f32>, tensor<i8>)
     reducer(%arg1: tensor<f32>, %arg3: tensor<f32>) (%arg2: tensor<i8>, %arg4: tensor<i8>)  {
      %4 = stablehlo.compare  GT, %arg1, %arg3,  FLOAT : (tensor<f32>, tensor<f32>) -> tensor<i1>
      %5 = stablehlo.compare  NE, %arg1, %arg1,  FLOAT : (tensor<f32>, tensor<f32>) -> tensor<i1>
      %6 = stablehlo.or %4, %5 : tensor<i1>
      %7 = stablehlo.compare  EQ, %arg1, %arg3,  FLOAT : (tensor<f32>, tensor<f32>) -> tensor<i1>
      %8 = stablehlo.compare  LT, %arg2, %arg4,  SIGNED : (tensor<i8>, tensor<i8>) -> tensor<i1>
      %9 = stablehlo.and %7, %8 : tensor<i1>
      %10 = stablehlo.or %6, %9 : tensor<i1>
      %11 = stablehlo.select %6, %arg1, %arg3 : tensor<i1>, tensor<f32>
      %12 = stablehlo.select %10, %arg2, %arg4 : tensor<i1>, tensor<i8>
      stablehlo.return %11, %12 : tensor<f32>, tensor<i8>
    }
    return %3#1 : tensor<i8>
  }
}
