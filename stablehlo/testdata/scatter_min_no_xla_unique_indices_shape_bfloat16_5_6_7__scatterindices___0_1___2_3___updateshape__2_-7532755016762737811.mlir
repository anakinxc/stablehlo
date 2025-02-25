// RUN-DISABLED: stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt -inline | stablehlo-translate --interpret
// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = stablehlo.constant dense<[[0, 1], [2, 3]]> : tensor<2x2xi32>
    %1:2 = call @inputs() : () -> (tensor<5x6x7xbf16>, tensor<2x7xbf16>)
    %2 = call @expected() : () -> tensor<5x6x7xbf16>
    %3 = "stablehlo.scatter"(%1#0, %0, %1#1) ({
    ^bb0(%arg0: tensor<bf16>, %arg1: tensor<bf16>):
      %5 = stablehlo.minimum %arg0, %arg1 : tensor<bf16>
      stablehlo.return %5 : tensor<bf16>
    }) {scatter_dimension_numbers = #stablehlo.scatter<update_window_dims = [1], inserted_window_dims = [0, 1], scatter_dims_to_operand_dims = [0, 1], index_vector_dim = 1>, unique_indices = true} : (tensor<5x6x7xbf16>, tensor<2x2xi32>, tensor<2x7xbf16>) -> tensor<5x6x7xbf16>
    %4 = stablehlo.custom_call @check.eq(%3, %2) : (tensor<5x6x7xbf16>, tensor<5x6x7xbf16>) -> tensor<i1>
    return %4 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<5x6x7xbf16>, tensor<2x7xbf16>) {
    %0 = stablehlo.constant dense<"0xA23F45BF6D40994080C0CE3E75C09240E43E91C0A14093C0FC3F934008C1993FBC40D33F8E409ABF94C0BF3E9CBF2240C24080BFC13E274027404EC0F7BECC40DCBF6ABF9640AB400B409FC0AF3F56C02A3D6F3F15C1703E0BC083C089C028C08EC081BE12C0404073C005BF8D400DC070BF213F3ABF2CBEB1BE07403740A8C09BBF95C003BDE83F02BF84C0E1BF80C08CC077C08D402DBF68408EBF8240EEBF98C03AC03E4009C0A04084C027401A405C3E89BF36C0EBBF2A3F19C0513F91BFFB3F25C0103F0CC0064093BFB3BF63C0CE3FD23E4040AB3ED23FF63ED4BFF93F163F8140A03FEA3FD63FF7BD8240D33D1CBF28401D40A7BF643F0E4057409ABF0F40F1BE0A4011C1614088406440BCBEC63D653F3BC0EB3F753FD83F9DBF93BE7FC0E13F9AC018BF83C00FBF023F32C0C4C0B3C0944055BF59C089BEF0BF254063BFA03F99C090BF923F24BE8E408F4086C06640E8BF52407DC05B4002403B3F44C0DCC0B4BD0D40CB40223F673E4840A740303E16416AC0D23F9CC038C05940394022C0493F06C1D6BF13C0A93E904027BF81BF874081BEA83F1FC0A33F4FC09240FEBF"> : tensor<5x6x7xbf16>
    %1 = stablehlo.constant dense<[[-3.574220e-01, 4.593750e+00, 1.039060e+00, -8.046880e-01, -2.375000e+00, 2.250000e+00, -8.085930e-01], [2.531250e+00, 3.656250e+00, 1.617190e+00, -2.078130e+00, -2.796880e+00, 1.337890e-01, 1.601560e-01]]> : tensor<2x7xbf16>
    return %0, %1 : tensor<5x6x7xbf16>, tensor<2x7xbf16>
  }
  func.func private @expected() -> tensor<5x6x7xbf16> {
    %0 = stablehlo.constant dense<"0xA23F45BF6D40994080C0CE3E75C0B7BEE43E91C04EBF93C0FC3F4FBF08C1993FBC40D33F8E409ABF94C0BF3E9CBF2240C24080BFC13E274027404EC0F7BECC40DCBF6ABF9640AB400B409FC0AF3F56C02A3D6F3F15C1703E0BC083C089C028C08EC081BE12C0404073C005BF8D400DC070BF213F3ABF2CBEB1BE07403740A8C09BBF95C003BDE83F02BF84C0E1BF80C08CC077C08D402DBF68408EBF8240EEBF98C03AC03E4009C0A04084C027401A405C3E89BF36C0EBBF2A3F19C0513F91BFFB3F25C0103F0CC0064093BFB3BF63C0CE3FD23E4040AB3E05C033C0D4BF243E163F8140A03FEA3FD63FF7BD8240D33D1CBF28401D40A7BF643F0E4057409ABF0F40F1BE0A4011C1614088406440BCBEC63D653F3BC0EB3F753FD83F9DBF93BE7FC0E13F9AC018BF83C00FBF023F32C0C4C0B3C0944055BF59C089BEF0BF254063BFA03F99C090BF923F24BE8E408F4086C06640E8BF52407DC05B4002403B3F44C0DCC0B4BD0D40CB40223F673E4840A740303E16416AC0D23F9CC038C05940394022C0493F06C1D6BF13C0A93E904027BF81BF874081BEA83F1FC0A33F4FC09240FEBF"> : tensor<5x6x7xbf16>
    return %0 : tensor<5x6x7xbf16>
  }
}

