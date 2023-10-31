import 'package:pokequiz/utils/constants.dart';

class Pokemon {
  final String name;
  final String url;

  // "https://pokeapi.co/api/v2/pokemon/1/"
  // split('/')
  // ['https:',,'pokeapi.co','api','v2','pokemon','1',]
  // reversed
  // [,'1','pokemon','v2','api','pokeapi.co',,'https']
  // skip(1)
  // ['1','pokemon','v2','api','pokeapi.co',,'https']
  // first
  // '1'

  get id => int.parse(url.split('/').reversed.skip(1).first);

  get image => '$pokemonImgUrl/$id.png';

  Pokemon({required this.name, required this.url});

  factory Pokemon.fromJson(Map<String, dynamic> jsonData) {
    return Pokemon(name: jsonData['name'], url: jsonData['url']);
  }
}
