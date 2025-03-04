// RUN: stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt -inline | stablehlo-translate --interpret
// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = call @inputs() : () -> tensor<20x20xf32>
    %1 = call @expected() : () -> tensor<20x20xf32>
    %2 = stablehlo.abs %0 : tensor<20x20xf32>
    %3 = stablehlo.constant dense<5.000000e-01> : tensor<20x20xf32>
    %4 = stablehlo.constant dense<2.000000e+00> : tensor<20x20xf32>
    %5 = stablehlo.constant dense<3.200000e+01> : tensor<20x20xf32>
    %6 = stablehlo.constant dense<8.000000e+00> : tensor<20x20xf32>
    %7 = stablehlo.multiply %3, %2 : tensor<20x20xf32>
    %8 = stablehlo.subtract %7, %4 : tensor<20x20xf32>
    %9 = stablehlo.constant dense<0.000000e+00> : tensor<20x20xf32>
    %10 = stablehlo.constant dense<0.000000e+00> : tensor<20x20xf32>
    %11 = stablehlo.constant dense<0.000000e+00> : tensor<20x20xf32>
    %12 = stablehlo.multiply %8, %9 : tensor<20x20xf32>
    %13 = stablehlo.subtract %12, %10 : tensor<20x20xf32>
    %14 = stablehlo.constant dense<9.38153732E-9> : tensor<20x20xf32>
    %15 = stablehlo.add %13, %14 : tensor<20x20xf32>
    %16 = stablehlo.multiply %8, %15 : tensor<20x20xf32>
    %17 = stablehlo.subtract %16, %9 : tensor<20x20xf32>
    %18 = stablehlo.constant dense<-4.44505908E-8> : tensor<20x20xf32>
    %19 = stablehlo.add %17, %18 : tensor<20x20xf32>
    %20 = stablehlo.multiply %8, %19 : tensor<20x20xf32>
    %21 = stablehlo.subtract %20, %15 : tensor<20x20xf32>
    %22 = stablehlo.constant dense<2.00329481E-7> : tensor<20x20xf32>
    %23 = stablehlo.add %21, %22 : tensor<20x20xf32>
    %24 = stablehlo.multiply %8, %23 : tensor<20x20xf32>
    %25 = stablehlo.subtract %24, %19 : tensor<20x20xf32>
    %26 = stablehlo.constant dense<-8.568720e-07> : tensor<20x20xf32>
    %27 = stablehlo.add %25, %26 : tensor<20x20xf32>
    %28 = stablehlo.multiply %8, %27 : tensor<20x20xf32>
    %29 = stablehlo.subtract %28, %23 : tensor<20x20xf32>
    %30 = stablehlo.constant dense<3.47025139E-6> : tensor<20x20xf32>
    %31 = stablehlo.add %29, %30 : tensor<20x20xf32>
    %32 = stablehlo.multiply %8, %31 : tensor<20x20xf32>
    %33 = stablehlo.subtract %32, %27 : tensor<20x20xf32>
    %34 = stablehlo.constant dense<-1.32731639E-5> : tensor<20x20xf32>
    %35 = stablehlo.add %33, %34 : tensor<20x20xf32>
    %36 = stablehlo.multiply %8, %35 : tensor<20x20xf32>
    %37 = stablehlo.subtract %36, %31 : tensor<20x20xf32>
    %38 = stablehlo.constant dense<4.78156508E-5> : tensor<20x20xf32>
    %39 = stablehlo.add %37, %38 : tensor<20x20xf32>
    %40 = stablehlo.multiply %8, %39 : tensor<20x20xf32>
    %41 = stablehlo.subtract %40, %35 : tensor<20x20xf32>
    %42 = stablehlo.constant dense<-1.61760821E-4> : tensor<20x20xf32>
    %43 = stablehlo.add %41, %42 : tensor<20x20xf32>
    %44 = stablehlo.multiply %8, %43 : tensor<20x20xf32>
    %45 = stablehlo.subtract %44, %39 : tensor<20x20xf32>
    %46 = stablehlo.constant dense<5.122860e-04> : tensor<20x20xf32>
    %47 = stablehlo.add %45, %46 : tensor<20x20xf32>
    %48 = stablehlo.multiply %8, %47 : tensor<20x20xf32>
    %49 = stablehlo.subtract %48, %43 : tensor<20x20xf32>
    %50 = stablehlo.constant dense<-0.00151357241> : tensor<20x20xf32>
    %51 = stablehlo.add %49, %50 : tensor<20x20xf32>
    %52 = stablehlo.multiply %8, %51 : tensor<20x20xf32>
    %53 = stablehlo.subtract %52, %47 : tensor<20x20xf32>
    %54 = stablehlo.constant dense<0.0041564228> : tensor<20x20xf32>
    %55 = stablehlo.add %53, %54 : tensor<20x20xf32>
    %56 = stablehlo.multiply %8, %55 : tensor<20x20xf32>
    %57 = stablehlo.subtract %56, %51 : tensor<20x20xf32>
    %58 = stablehlo.constant dense<-0.0105640851> : tensor<20x20xf32>
    %59 = stablehlo.add %57, %58 : tensor<20x20xf32>
    %60 = stablehlo.multiply %8, %59 : tensor<20x20xf32>
    %61 = stablehlo.subtract %60, %55 : tensor<20x20xf32>
    %62 = stablehlo.constant dense<0.0247264486> : tensor<20x20xf32>
    %63 = stablehlo.add %61, %62 : tensor<20x20xf32>
    %64 = stablehlo.multiply %8, %63 : tensor<20x20xf32>
    %65 = stablehlo.subtract %64, %59 : tensor<20x20xf32>
    %66 = stablehlo.constant dense<-0.0529459827> : tensor<20x20xf32>
    %67 = stablehlo.add %65, %66 : tensor<20x20xf32>
    %68 = stablehlo.multiply %8, %67 : tensor<20x20xf32>
    %69 = stablehlo.subtract %68, %63 : tensor<20x20xf32>
    %70 = stablehlo.constant dense<0.102643661> : tensor<20x20xf32>
    %71 = stablehlo.add %69, %70 : tensor<20x20xf32>
    %72 = stablehlo.multiply %8, %71 : tensor<20x20xf32>
    %73 = stablehlo.subtract %72, %67 : tensor<20x20xf32>
    %74 = stablehlo.constant dense<-0.176416516> : tensor<20x20xf32>
    %75 = stablehlo.add %73, %74 : tensor<20x20xf32>
    %76 = stablehlo.multiply %8, %75 : tensor<20x20xf32>
    %77 = stablehlo.subtract %76, %71 : tensor<20x20xf32>
    %78 = stablehlo.constant dense<0.252587199> : tensor<20x20xf32>
    %79 = stablehlo.add %77, %78 : tensor<20x20xf32>
    %80 = stablehlo.subtract %79, %71 : tensor<20x20xf32>
    %81 = stablehlo.constant dense<5.000000e-01> : tensor<20x20xf32>
    %82 = stablehlo.multiply %80, %81 : tensor<20x20xf32>
    %83 = stablehlo.multiply %2, %82 : tensor<20x20xf32>
    %84 = stablehlo.divide %5, %2 : tensor<20x20xf32>
    %85 = stablehlo.subtract %84, %4 : tensor<20x20xf32>
    %86 = stablehlo.constant dense<0.000000e+00> : tensor<20x20xf32>
    %87 = stablehlo.constant dense<0.000000e+00> : tensor<20x20xf32>
    %88 = stablehlo.constant dense<0.000000e+00> : tensor<20x20xf32>
    %89 = stablehlo.multiply %85, %86 : tensor<20x20xf32>
    %90 = stablehlo.subtract %89, %87 : tensor<20x20xf32>
    %91 = stablehlo.constant dense<-3.83538046E-9> : tensor<20x20xf32>
    %92 = stablehlo.add %90, %91 : tensor<20x20xf32>
    %93 = stablehlo.multiply %85, %92 : tensor<20x20xf32>
    %94 = stablehlo.subtract %93, %86 : tensor<20x20xf32>
    %95 = stablehlo.constant dense<-2.63146891E-8> : tensor<20x20xf32>
    %96 = stablehlo.add %94, %95 : tensor<20x20xf32>
    %97 = stablehlo.multiply %85, %96 : tensor<20x20xf32>
    %98 = stablehlo.subtract %97, %92 : tensor<20x20xf32>
    %99 = stablehlo.constant dense<-2.51223611E-7> : tensor<20x20xf32>
    %100 = stablehlo.add %98, %99 : tensor<20x20xf32>
    %101 = stablehlo.multiply %85, %100 : tensor<20x20xf32>
    %102 = stablehlo.subtract %101, %96 : tensor<20x20xf32>
    %103 = stablehlo.constant dense<-3.88256467E-6> : tensor<20x20xf32>
    %104 = stablehlo.add %102, %103 : tensor<20x20xf32>
    %105 = stablehlo.multiply %85, %104 : tensor<20x20xf32>
    %106 = stablehlo.subtract %105, %100 : tensor<20x20xf32>
    %107 = stablehlo.constant dense<-1.10588939E-4> : tensor<20x20xf32>
    %108 = stablehlo.add %106, %107 : tensor<20x20xf32>
    %109 = stablehlo.multiply %85, %108 : tensor<20x20xf32>
    %110 = stablehlo.subtract %109, %104 : tensor<20x20xf32>
    %111 = stablehlo.constant dense<-0.00976109784> : tensor<20x20xf32>
    %112 = stablehlo.add %110, %111 : tensor<20x20xf32>
    %113 = stablehlo.multiply %85, %112 : tensor<20x20xf32>
    %114 = stablehlo.subtract %113, %108 : tensor<20x20xf32>
    %115 = stablehlo.constant dense<0.778576254> : tensor<20x20xf32>
    %116 = stablehlo.add %114, %115 : tensor<20x20xf32>
    %117 = stablehlo.subtract %116, %108 : tensor<20x20xf32>
    %118 = stablehlo.constant dense<5.000000e-01> : tensor<20x20xf32>
    %119 = stablehlo.multiply %117, %118 : tensor<20x20xf32>
    %120 = stablehlo.sqrt %2 : tensor<20x20xf32>
    %121 = stablehlo.divide %119, %120 : tensor<20x20xf32>
    %122 = stablehlo.compare  LE, %2, %6 : (tensor<20x20xf32>, tensor<20x20xf32>) -> tensor<20x20xi1>
    %123 = stablehlo.select %122, %83, %121 : tensor<20x20xi1>, tensor<20x20xf32>
    %124 = stablehlo.sign %0 : tensor<20x20xf32>
    %125 = stablehlo.multiply %124, %123 : tensor<20x20xf32>
    %126 = stablehlo.custom_call @check.eq(%125, %1) : (tensor<20x20xf32>, tensor<20x20xf32>) -> tensor<i1>
    return %126 : tensor<i1>
  }
  func.func private @inputs() -> tensor<20x20xf32> {
    %0 = stablehlo.constant dense<"0x0DEB594082D204C0674C053FA0B3484040D61FBE6F5A26BF19893240F94216405B0E8DBE44789BC0D8B085BFEB118A3E89B92BC0C10557C0B81B44407926A3BF2ECB6CC0BB306440DA3469C0C448DFBF9602C140CBCEEABF27758040FAD76240682A59C0EDE4F33FACA7204017F4C0BE7C87E7C0BE713BBFE5730AC06A7294C0EC5BE53EE6EB1940F4382A40B99FFA3FEA53B83E8DFC4DC0CD6406BEE6FA29C06B198CC03AB18FC061908F401782AEBFB196A73DCF9F0BC1465DB43F1A40393FCEE84BC052434940258203C01FCD5C40BBB894C0E9315DC01C68C5BEF221CCC0459204BEF7FE0EC03905B83F460DC0C0D606723E2B307DC047E30BC0C8778240C2B898C032BA9AC0A4B016C0EA61C340CA8600C0C781F83D60E7BA40674AFA3E912D42C03263F23F8B4463BF022DF7BFA6DCF7BF2B8E2740969EB33FB8108A3F81105C40D5BD853FEE7CDF3F81A981C021F9303E369DA43E596CE6BFB5DBD6BF151213C04E3E3EC0E43C6C3F828D04C05CEB854045A757C0BF69EDBF44F76E4062ED823E90B9EC3FB4F7B4400EFAB1BD77CB24402122173F85D1B04096FE83BEDF65BF409977013F2AC856C0E739143FB1921B4069FD893E5904583F9CB4B93D2BB69240FF5555BFF9CB4C40B7E4B83F6DE1D5BEB18D8A3ECE722EBFBBFFA13F20DF2D40DDC8513F442461BE32DEB6BF5E43A040500AFBBF57FF353FD8B6543FD9B2ADBFDCA432BF7C4D90BF1E8129407A5D38BFB8E95AC0335048C08DC471BF7707CC3D86720040E9D957400EF20040E2C596BF4CF15240E53ABBBD3DB1F73FDFE3B3BEB429E6BFC89D9C3D1206A5BE4F29393F7F8FB83F1C91813F917003BF51500FC099F305BF09BFC0C076FD93BFFE622FC0283A943F81363A3F871E343E1F32C040C3B1423FD042A5C0F8B947BF3A317A4047D5BC3FDFCD03BFD898E33F0D7FB9C09FDD574082B015407F81FB3EBA30E9BFAF4681C06E663540189CF8BF1089E93EF6F135C0FA3B983EC5F5B2BFF1F31B3F670377BE3E4E5CBD7FB0703F757174BF758E4C404DA1173F377ACFC0B02630407AAB77BE04C9BFBEAE224EC0DB024E3F53EBE040C19FE7BE3B0999BFF39A2FC09FE43D40F9741AC04DBD36C03099CCC02CF892BEAD96A5BFF85D843E53729F3F90244CC0FCAE14406A8026C0FE04E0402565EC3E45049BC05E5A2B40CE9626C0086219C0A7F388C0C04D51BF4899444106EBB34049DFAFC0969A0140E0C4DBBF354D67BF53390540F37BE1BF9A4E923F76985B3F8A215BBFD64E54C0025087C01EA4B03FD689F0C03C80D13FBDAEABBE54D46D404AD3173F36B2A3C0DB31F33F6FC41CC0061E253F4E9C413F215FC2C02D851FBF6995C1C01A1C61BF66E96DBE303BD9BEDFF8BB40BC2A44BF625D25C0601453C03A3BD23F5AE16D40C1D382C0BCB7D33FC5B2823FE4DC87C0AA14D5BE627FDFBEC097F43E0C82843F7A1ECCBE159DE9BF4A0BC73F0CB12CC0DC0831BF797747C02684F9BE570CCB4037C7F13D78E5C640A763A5C032BB9AC0998C8940DE3EED3E68439EBE4D889E3D14FEB43F4C39283EA0B311C024B31BC0F41E2DC066F86F3F479B1BC03F505AC0D532F7BFF46772C0C5BE70C0352D47C0BA7A29C05899CBC0516E2940167243BF56513EBF455C0DC062DBC640A92FA8BFA00349402ADB29C0CC4011402939EEBF9126C13FF60DF6BFEE772140F5CE20BE5C757840A18B4E4049E19A3FA6EE1B40115FB7BF46AD023D8102A1BF54C04E3FDDD0A3C07349F9BF378C9B406CCBB83F21B404BE0DFA36C003B0ADBF93BCF9C0B877BABF68CB323E13924AC01F1B8BBF4A80CBBE6E7415C0D8AAF03EDA58CA4087C431C03D07C9409EED88BE8A27ADC0C30C67BF17D8E93D6FEABBBF0899AD3FBC02CBBF676131409340A23FED5A983FB79D1E4026809640A3DE5540278277C0A9C4C3BF8E7A864056745DBF92F610BFB9EEAF3FB13C253E30D0CDBF44312740EAEF19C0BCC027C0DA6980BECAFB813F326AB0405027D6BF24967FC00A788140B12721BF6F9692BF9CF0AF40DD256AC0AB1F89C0CB19754054D87CC006FC8E40C71B72C06B1F27C074CB4DC09829EB3F2880C53F4ADDBBBF52B871408EADDFBFF97ECEC04A71833F47980FBEE87CA1BFE0BCDF3F4CE5733F84D32AC0AAB010C039569340150C3BC0FC062DC029E7BCBECC640740CC8E0640B590A2BFBDCA4B40514A9C3FC18D54BEFBCCDC3FD42D55C0237457BD4E693AC01DC9A4BFBC6595C0"> : tensor<20x20xf32>
    return %0 : tensor<20x20xf32>
  }
  func.func private @expected() -> tensor<20x20xf32> {
    %0 = stablehlo.constant dense<"0x6EAD413EBF465BBED2D0233EB7DC463E872789BD4A0D37BE86C34D3E127A563E4337D8BDCDDA29BEC70657BED3CAD43D9CE64FBEF28842BED646483ED4115EBE74403CBE41B03E3E9B423DBE87765FBED55A1B3EB3965EBEEFCC363E54133F3E52E641BED6BD5D3E7357533E66BB06BE0C9C0FBE279E40BEBDD059BE8DFE2CBE0F40163E6563553EFD5E503ECB095D3EA7B1023EE33F45BE503C6CBD677250BE8EED30BE0F352FBE9C442F3EC8625FBED88C1A3DB91B04BEF2D35F3E7EB53F3E9FE145BEA9B0463EF8995BBE82D4403E63DE2CBE01B740BEADC208BE41AF17BE0E6F69BD819158BEE807603ED5AE1BBEF16AC03DA5C837BE6A6D59BEDFC0353EBA102BBEF52D2ABEB45956BE038D1A3E5A505CBE0C845C3DD37A1D3E8D241E3ED1DF48BEFBE35D3ED41E4EBEF1675DBE85555DBE3D34513EA6C75F3E7078583EC90B413E4F0B573E23735F3EE12B36BEFE70953D26CEF13D2EF35EBE2BEF5FBE7F6857BEF2184ABECB78503EF3575BBEE9FC333EFB5842BEDD5B5EBE7DA53B3E906ECC3DB06B5E3E3BA01F3E345123BD1110523EBCE52E3EE02C213E4EB2CDBD71E81B3E2F33213E419B42BE5C352D3E15E4543E29B3D43D97D64A3E19C8293D31CB2D3E88FF49BE709C453E4D12603E60F10FBE7459D53DB7F23ABE23E65D3E523A4F3E80D9483E89CCB5BD01F95FBEDBCB273E27FE5CBE6F533E3ED2CC493E15505FBEDEDA3CBE1A445ABE7A98503E38563FBE666241BE38FB46BEBACF51BE73E9383D0F555C3EF449423E4B375C3E26D45BBEEDC0433E0F0D2BBD165A5D3E2A8F00BE64F85EBE2A31113D8A3AF2BDF0AB3F3E6D0E603ECA83553EBE8E22BEAC7A58BEC34024BEE9711BBE30315BBE9EC04EBE993F5B3E2A1C403ED7A6973D2EA21B3E187D433E53B825BEA45D45BE3795383E0338603E4DCE22BE232A5F3E37FB1DBEDC48423E27A5563E5C941E3ECEB95EBE5C5F36BE4FDD4C3E44415DBECEE1173E87B14CBEB6AAE43D43BC5FBE299A313E247CC3BD4CD8D0BC7D8E513E476E52BE2AAF453E812E2F3EDCA016BE2F834E3EEAE2C3BD8E3106BE533445BE5595473E9971113E8B2317BEFD4E5CBE0EAF4EBEE5344A3E363A55BEBF714CBE458917BE9CDFDEBD46685EBE0023CE3D877E5D3E69CF45BE8EF0563E438851BEE2B2113E92FB183E800D2ABE6904503E4D8151BEB58C55BE6B7832BEDFB048BE02C6E13D8F03203ED58821BE8D0F5C3EABAD5FBEB7344FBEFB2C5B3EB9505FBE0AC85A3E90EC4B3E10C94BBE2D5843BE714933BE6F905F3EE2360DBE0626603EED02F9BD6EF63B3E054B2F3ED75C26BEA5CF5D3E7E8754BE576E363E7812433E59E41ABEA48733BECB281BBE3D854DBEFFDCBDBDF55711BE241A1D3E2C0C44BEC4E251BE65B643BE9E1F603ECBF23B3E559135BE8511603ED5F1553E030333BE059B0FBE0FE913BE6D101C3EB79B563E4BBF0BBEBCB05EBE0359603E0C994FBEE2213CBECA3D47BEFDDC1DBE1508183ED83A573DA261193EEDAA25BE872D2ABED32C323EB64E193E2226EBBD64D5123DDCDD5F3E77388F3D48CD57BE47DA54BE96764FBE8962513E7EE154BE988F41BE56675DBE30B23ABE54273BBE9F5447BE789A50BEE2DA17BE599E503E56C643BE94C741BEFF0559BEF564193E9CBB5EBE2EC4463E527C50BE17EE573E01495EBEDD50603EB7855DBE5F17533EC1DC89BD830C393E7E14453EE5AC5C3E4AC8543EAFFF5FBEEF2D7D3C1DBF5DBEE2D5473E305026BEC12E5DBE18D2293E2911603E32A369BDB35E4CBED04F5FBEA3E20ABE282360BE04B9963D3A4A46BE7BCA58BECD790BBEC6B656BE269A1A3ED341183E3F014EBE1CAF183EDB78D3BD299422BEB6234FBE95F3503D8D3060BEB04D5F3EFF4E60BE60204E3EE5EF5D3EEE2A5C3E63F7533E840F2C3EC8E0423E294E39BE055860BEA5B4333EF4784CBE87422BBEDA815F3E6B128D3DEA4060BE3051513E306255BE792451BE646EC9BDAAAC553E0954213E68F75FBE522637BEA345363E806434BEEAD95ABE3D82213E95FE3CBEA36232BE72F5393EF9DF37BEFB8A2F3E1FC73ABEBE5651BECB4E45BEDE8E5E3E9D59603E1D3060BE80E23A3EF16F5FBEA3EF16BE9838563E3F3A7ABD24D25DBEF16E5F3E374E523EA02E50BE211758BE2E812D3E5E184BBE1C7E4FBE99DA04BE3E9F5A3E55D65A3EDBFB5DBECAEA453E10F15C3EB8A4ADBD2B9E5F3E861543BEF37BCCBC464B4BBEB44C5EBE828F2CBE"> : tensor<20x20xf32>
    return %0 : tensor<20x20xf32>
  }
}

