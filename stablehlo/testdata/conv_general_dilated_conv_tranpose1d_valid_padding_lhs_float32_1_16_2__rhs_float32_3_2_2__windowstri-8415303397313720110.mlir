// RUN-DISABLED: stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt -inline | stablehlo-translate --interpret
// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0:2 = call @inputs() : () -> (tensor<1x16x2xf32>, tensor<3x2x2xf32>)
    %1 = call @expected() : () -> tensor<1x33x2xf32>
    %2 = stablehlo.convolution(%0#0, %0#1) dim_numbers = [b, 0, f]x[0, i, o]->[b, 0, f], window = {pad = [[2, 2]], lhs_dilate = [2]} {batch_group_count = 1 : i64, feature_group_count = 1 : i64} : (tensor<1x16x2xf32>, tensor<3x2x2xf32>) -> tensor<1x33x2xf32>
    %3 = stablehlo.custom_call @check.eq(%2, %1) : (tensor<1x33x2xf32>, tensor<1x33x2xf32>) -> tensor<i1>
    return %3 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<1x16x2xf32>, tensor<3x2x2xf32>) {
    %0 = stablehlo.constant dense<[[[-4.07882929, 0.10345453], [3.95936775, 0.182167158], [-1.8219012, -4.8078413], [2.36134338, 0.374701232], [0.128649756, 1.22263598], [-3.09423828, -6.52680492], [-0.486474901, -0.499504626], [-1.13961768, -0.457600832], [-3.35133338, -2.06962872], [3.71505165, 0.420098811], [-0.879057407, 1.1707021], [-0.550113559, 2.29026461], [-0.742595374, 1.17629492], [1.32067657, 1.71534801], [-2.61802197, 0.242558643], [-2.48261404, 1.57736623]]]> : tensor<1x16x2xf32>
    %1 = stablehlo.constant dense<[[[-2.0630188, -1.5816139], [-0.709697485, -4.2396903]], [[-1.26467288, -5.61277342], [0.423362285, -0.584941268]], [[-2.145080e+00, -1.7616626], [-3.43366671, -3.3343122]]]> : tensor<3x2x2xf32>
    return %0, %1 : tensor<1x16x2xf32>, tensor<3x2x2xf32>
  }
  func.func private @expected() -> tensor<1x33x2xf32> {
    %0 = stablehlo.constant dense<[[[8.39418697, 6.8405714], [5.20218372, 22.8330307], [-0.777382135, -1.56995428], [-4.93018246, -22.3295918], [12.1191158, 12.2058954], [0.268650532, 13.0382233], [0.818859577, 17.8560429], [-2.82769251, -13.4728632], [-9.61150932, -9.62663841], [0.354918063, -1.43725228], [27.9151535, 21.8263378], [1.14999604, 21.1850548], [13.774189, 35.0880318], [0.403760195, 3.02265406], [5.37392426, 6.42056656], [1.24751258, 6.66408538], [16.9711037, 16.5472279], [3.36213756, 20.0208855], [-1.02888858, 6.12969207], [-4.5204711, -21.097477], [-10.0965166, -10.0117493], [1.60735118, 4.24915791], [-5.70130062, -10.240428], [1.6653254, 1.7479924], [-2.93657851, -11.4538774], [1.43713903, 3.47995639], [-8.02571582, -11.8587189], [-0.944010198, -8.41603565], [0.841042757, -5.55803967], [3.41363168, 14.5524817], [5.13814163, 2.22642279], [3.80749202, 13.0116835], [4.00222635, -2.76100755]]]> : tensor<1x33x2xf32>
    return %0 : tensor<1x33x2xf32>
  }
}

