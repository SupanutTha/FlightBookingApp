class AirlineLogo {
  final String id;
  final String lcc;
  final String name;
  final String logo;

  AirlineLogo({
    required this.id,
    required this.lcc,
    required this.name,
    required this.logo,
  });

  Map<String , dynamic> toMap(){
    return{
      'id' : id,
      'lcc' : lcc,
      'name' : name,
      'logo' : logo,
    };
  }

  factory AirlineLogo.fromJson(Map<String ,dynamic> map){
    return AirlineLogo(
      id: map['id'], 
      lcc: map['lcc'], 
      name: map['name'], 
      logo: map['logo']
      );
  }
}