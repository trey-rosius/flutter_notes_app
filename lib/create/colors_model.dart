class ColorModel{
  int? id;
  String? codeHex;
  int? colorId;

  ColorModel({this.id,this.codeHex,this.colorId});

}
List<ColorModel> colorList = [
  ColorModel(codeHex: "efa2ba",
  colorId: 0xFFefa2ba),
  ColorModel(codeHex: 'fcc117',
      colorId: 0xFFfcc117),
  ColorModel(codeHex: 'fe97c1',
      colorId: 0xFFfe97c1),
  ColorModel(codeHex: '59d9e4',
      colorId: 0xFF59d9e4),
  ColorModel(codeHex: '565656',
      colorId: 0xFF565656),
  ColorModel(codeHex: 'a06ef3',
      colorId: 0xFFa06ef3),
  ColorModel(codeHex: 'd134be',
      colorId: 0xFFd134be),
  ColorModel(codeHex:'0143a0',
      colorId: 0xFF0143a0),

];