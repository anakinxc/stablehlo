// RUN: diff <(stablehlo-opt %s --stablehlo-legalize-to-vhlo --vhlo-to-version=target=current -emit-bytecode | stablehlo-opt --vhlo-legalize-to-stablehlo) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = call @inputs() : () -> tensor<20x20xf32>
    %1 = call @expected() : () -> tensor<20x20xf32>
    %2 = stablehlo.negate %0 : tensor<20x20xf32>
    %3 = stablehlo.custom_call @check.eq(%2, %1) : (tensor<20x20xf32>, tensor<20x20xf32>) -> tensor<i1>
    return %3 : tensor<i1>
  }
  func.func private @inputs() -> tensor<20x20xf32> {
    %0 = stablehlo.constant dense<"0x942A303F3866C83F5451B03F2C8038C056E615C0BBFB9E3F0BC8CF3FADD71EC0C154B9C0868987BFCB136B409DB9FBBEAED4C3BF85245A405B06B6C084B18BC05476A7BEC56082BE2B2DA1BFE1828240B17F4DC087323740561827403AD2DA408F6026403EFF55BFD66F93BFC7BC52C0A6420FC062CDAEBFE2FF1CC1510191BD26CEF83FCF4A313F6B46673FF79A2640825F5240E19C1A40BCD533C01E0A823EFE587C40A0E3BEBEF5DAD73EAC992F3E1646DB3E1881D53E387DE23F0E27A43FB0749840A2177D3F17C7E6BE8D2C14C0DBA0D53FAB762D403E2E64BF9B0B05C0F81AB5BF313B294038F7DF3F13FEDBBE87DC93C0042BCABF3026E5BF3E9A37C0A972DDBE39FB99BFC3F0DABEC4100A3EB7549C3D5815AC3FD40339C0F2CBE73E4DDACABF43D4AF3F15812B3D7DA1813E369BB740D2BC65C0A284EC3F352245C0FAEB5CBE7250AE3E3CBCA5408004773FBD449240A341A1403A5B36408D830FBF87CFA9BEF2141340782D19C061CB0FBF41818C40A3215BBF39E53FBFA1004740BBF2B8BED1368DC04037F03F282FA73F14E395408FB34F3A773207C0ABF9DB40B4DE8ABE0791283FA1772B409989DEBFEAABDABECCFC68404BABAF40F27B8C3F373976BF7E1BC540F5910A3F1ED2B4C05F5045C06232C3BF3F4AB33FDE440DBFA2BE0A3C26FA55BF8A37153FB1B9BC3FA250813E2FCC003F9550ABBEBD60B8BF7B60A7C04C915ABE99C45040E3A6EA4019AAAA3E5AD48040F2FC2FBF6D002A40F06DBD3F1377543F768212C0788457BF755435C0D68DE6BF679788C0E3278640EEC134403DC96C3F5285853FFA62E23F03C41DC0E841E1BFBA67BEBEF1018D3F6A5ABE3E213EC5408C726640707A98C0A06916C017B45240D138E8BF03DC87C04AF55E406A6A373E891799BFC8BDA940BDBF17C1F70E434093DB5BBF823C1440281DD2BF0ED43DBF5F774140B899323F1FA46540C6EBE13F9D52B5C0A9AA973E8A0E133FEFCC0BC09761F93FDC936B40CF46AA3FC3D0AFBF6036B4C0E2628240BB713B40ECFC25BF4163664062AEA9BF3EEF684077172E409D68F63F8F54CA3F52900AC0218AF6BF7848A6C0761DA9BDFEA0B44072CB5FC06F619240D47BA3C09ABEFBC0D8A36D3FC8F08EBFC18813BF9800174043F92D4011992DBF294DDEBF2CA71EC06BD674BF4E4C6F40067692C052AF42407E5F4840EF0F34BE26A210BF82858B40400EF53D64D3A4BF8099DF3E529E3540179279C0204753C0B7B1613F76C50DC01A1243C0DCCBC2C04065A2BDD674253F59B6A23E315BF3BF052A6BC09D30FFBD9E068F4098F259BCCE24BC3F38F38A3E6B64D34035F78FBE57FAB73DF096A1BE394E93BFEA358BBEDFA6D43E3CED6440EE9773403418E53FFF87F240FA83DE3EE3972B3FEE3E413FB6C94E406D898FC0A8C891BFE5414ABFCED98CBF00DCD4BED3FF5540FAEE853F1B165BC0ED258D40ADE3F1BF6E439A3F29C2BB3FAA88C73FB5FD7AC0E080EBBE04A66A3F35BCE83F2610BDC094762840C4CA784090F1ECBFE00CB040FF8E78BF467B9C3FD5D5AEC01B5BE03F99FC3FC09A3A6CC05C109E3F72FB88C0346E753F81CC1BC0EEE4E0BFECBCE0BFE3134EBFBE6DFCBFE408C7C0DDD78240C56231400CFB1540CA75BE3F059542BF97A47840F52781BF7BCD41C03D3586BFFD332A3FA6395CC092180F405303DDC01FB9F03F62FB3BC0512A94BE70C6B23FD328C2BDE415CDBFFEBD38C094FFD8BC9E7395C0AF39ADBF9773CFC070945B40AC71BEBFB3EA2A40B1716AC08ED742C0BB359BC09C36F83F4A04A73EA6CE2BC0524E96C0EE244BC0BC0CAF406705324038FC943F025E93402BB2E1BEC1D7B13ED4183CC0A028983F737CAB3F93D66A40F984BFBFDC8F88BF2008A640A4D479C0136154C093377940A2E60540E9BDA33FF43DD8BF69419640525B50BF6AA8EC3F5FFBEABEDDBBD4BEB18B24405A4710BFBEC70DC0DAEFB83EADC1AFC03CE219C0AD2A89C0734CCC3F3D34D2404639BE3F1CFB1140833787C02A5113C025AA36BF330271BFF34D274093BCA53E69C251BC95B79BC0C7FA3BC0CC4A7540243743C059ACD8BD0A5D72BF8722963F7AD7683F4DA1753FB750733E8ADDDFBFAB50E1BFF77491C0320DD83F97B82AC0C46E2A4055C1013F2C79433F0F749F40325162BEB51F294034D8FEBE09EC0CC0FC55B6BF743814C0ABA9913E322F823FA1B394C0FAFD9BBEBAF0123E6742D1BF4DE0033FC9381EBE4266B1C0"> : tensor<20x20xf32>
    return %0 : tensor<20x20xf32>
  }
  func.func private @expected() -> tensor<20x20xf32> {
    %0 = stablehlo.constant dense<"0x942A30BF3866C8BF5451B0BF2C80384056E61540BBFB9EBF0BC8CFBFADD71E40C154B9408689873FCB136BC09DB9FB3EAED4C33F85245AC05B06B64084B18B405476A73EC560823E2B2DA13FE18282C0B17F4D40873237C0561827C03AD2DAC08F6026C03EFF553FD66F933FC7BC5240A6420F4062CDAE3FE2FF1C415101913D26CEF8BFCF4A31BF6B4667BFF79A26C0825F52C0E19C1AC0BCD533401E0A82BEFE587CC0A0E3BE3EF5DAD7BEAC992FBE1646DBBE1881D5BE387DE2BF0E27A4BFB07498C0A2177DBF17C7E63E8D2C1440DBA0D5BFAB762DC03E2E643F9B0B0540F81AB53F313B29C038F7DFBF13FEDB3E87DC9340042BCA3F3026E53F3E9A3740A972DD3E39FB993FC3F0DA3EC4100ABEB7549CBD5815ACBFD4033940F2CBE7BE4DDACA3F43D4AFBF15812BBD7DA181BE369BB7C0D2BC6540A284ECBF35224540FAEB5C3E7250AEBE3CBCA5C0800477BFBD4492C0A341A1C03A5B36C08D830F3F87CFA93EF21413C0782D194061CB0F3F41818CC0A3215B3F39E53F3FA10047C0BBF2B83ED1368D404037F0BF282FA7BF14E395C08FB34FBA77320740ABF9DBC0B4DE8A3E079128BFA1772BC09989DE3FEAABDA3ECCFC68C04BABAFC0F27B8CBF3739763F7E1BC5C0F5910ABF1ED2B4405F5045406232C33F3F4AB3BFDE440D3FA2BE0ABC26FA553F8A3715BFB1B9BCBFA25081BE2FCC00BF9550AB3EBD60B83F7B60A7404C915A3E99C450C0E3A6EAC019AAAABE5AD480C0F2FC2F3F6D002AC0F06DBDBF137754BF768212407884573F75543540D68DE63F67978840E32786C0EEC134C03DC96CBF528585BFFA62E2BF03C41D40E841E13FBA67BE3EF1018DBF6A5ABEBE213EC5C08C7266C0707A9840A069164017B452C0D138E83F03DC87404AF55EC06A6A37BE8917993FC8BDA9C0BDBF1741F70E43C093DB5B3F823C14C0281DD23F0ED43D3F5F7741C0B89932BF1FA465C0C6EBE1BF9D52B540A9AA97BE8A0E13BFEFCC0B409761F9BFDC936BC0CF46AABFC3D0AF3F6036B440E26282C0BB713BC0ECFC253F416366C062AEA93F3EEF68C077172EC09D68F6BF8F54CABF52900A40218AF63F7848A640761DA93DFEA0B4C072CB5F406F6192C0D47BA3409ABEFB40D8A36DBFC8F08E3FC188133F980017C043F92DC011992D3F294DDE3F2CA71E406BD6743F4E4C6FC00676924052AF42C07E5F48C0EF0F343E26A2103F82858BC0400EF5BD64D3A43F8099DFBE529E35C01792794020475340B7B161BF76C50D401A124340DCCBC2404065A23DD67425BF59B6A2BE315BF33F052A6B409D30FF3D9E068FC098F2593CCE24BCBF38F38ABE6B64D3C035F78F3E57FAB7BDF096A13E394E933FEA358B3EDFA6D4BE3CED64C0EE9773C03418E5BFFF87F2C0FA83DEBEE3972BBFEE3E41BFB6C94EC06D898F40A8C8913FE5414A3FCED98C3F00DCD43ED3FF55C0FAEE85BF1B165B40ED258DC0ADE3F13F6E439ABF29C2BBBFAA88C7BFB5FD7A40E080EB3E04A66ABF35BCE8BF2610BD40947628C0C4CA78C090F1EC3FE00CB0C0FF8E783F467B9CBFD5D5AE401B5BE0BF99FC3F409A3A6C405C109EBF72FB8840346E75BF81CC1B40EEE4E03FECBCE03FE3134E3FBE6DFC3FE408C740DDD782C0C56231C00CFB15C0CA75BEBF0595423F97A478C0F527813F7BCD41403D35863FFD332ABFA6395C4092180FC05303DD401FB9F0BF62FB3B40512A943E70C6B2BFD328C23DE415CD3FFEBD384094FFD83C9E739540AF39AD3F9773CF4070945BC0AC71BE3FB3EA2AC0B1716A408ED74240BB359B409C36F8BF4A04A7BEA6CE2B40524E9640EE244B40BC0CAFC0670532C038FC94BF025E93C02BB2E13EC1D7B1BED4183C40A02898BF737CABBF93D66AC0F984BF3FDC8F883F2008A6C0A4D4794013615440933779C0A2E605C0E9BDA3BFF43DD83F694196C0525B503F6AA8ECBF5FFBEA3EDDBBD43EB18B24C05A47103FBEC70D40DAEFB8BEADC1AF403CE21940AD2A8940734CCCBF3D34D2C04639BEBF1CFB11C0833787402A51134025AA363F3302713FF34D27C093BCA5BE69C2513C95B79B40C7FA3B40CC4A75C02437434059ACD83D0A5D723F872296BF7AD768BF4DA175BFB75073BE8ADDDF3FAB50E13FF7749140320DD8BF97B82A40C46E2AC055C101BF2C7943BF0F749FC03251623EB51F29C034D8FE3E09EC0C40FC55B63F74381440ABA991BE322F82BFA1B39440FAFD9B3EBAF012BE6742D13F4DE003BFC9381E3E4266B140"> : tensor<20x20xf32>
    return %0 : tensor<20x20xf32>
  }
}