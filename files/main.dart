main(List<String> args) {
  // Declarations
  var one = 1; // implicit
  int two = 2; // explicit
  const NAME = "NGUYEN"; // constante
  final surname =
      "Marc"; // constante initialisé plus tard dans un constructeur de class
  dynamic nombre = 32;
  nombre = "32";

  // Formatter avec print
  String world = "Earth";
  print('Hello $world!');

  // List
  List<int> list = [
    0,
    1,
    2,
  ];
  Map<String, int> map = {
    "zero": 0,
    "one": 1,
    "two": 2,
  };

  // map list
  List<int> list_incremented = list.map((elem) => elem + 1).toList();
  print(list_incremented);

  // Fonctions
  helloWorld() {
    print("1 Hello World");
  }

  // Arrow notation
  String helloWorld2() => "2 Hello World";

  // Lambdas/Anonymous Functions
  var helloWorld3 = () => "3 Hello World";

  helloWorld();
  print(helloWorld2());
  print(helloWorld3());

  // Sync
  String funcSync() => "Hello World";
  String funcMain() {
    var sortie = funcSync();
    return sortie;
  }

  print("3 ${funcMain()}");

  // Async
  Future<String> funcAsync() async => "4 Hello World";
  Future<String> funcAsyncMain() async {
    var sortie = await funcAsync();
    return sortie;
  }

  funcAsyncMain().then(print);
  funcAsync().then(print);

  // Speed control
  Future<String> printAsyncLente(String hello, String world) async =>
      Future.delayed(const Duration(seconds: 1), () => '$hello $world!');
  Future<String> printAsyncRapide(String hello, String world) async =>
      '$hello $world!';

  compareAsync() async {
    printAsyncLente("a Hello", "World").then(print);
    printAsyncRapide("a Salut", "Monde").then(print);
  }
  compareAsync();

  // Problème
  compareAsync2() async {
    var lent;
    var rapide;

    printAsyncLente("b Hello", "World").then((out) => lent = out);
    printAsyncRapide("b Salut", "Monde").then((out) => rapide = out);

    print(lent);
    print(rapide);
  }
  compareAsync2();

  compareAsync3() {
    var lent;
    var rapide;

    printAsyncLente("c Hello", "World").then((out) => lent = out);
    printAsyncRapide("c Salut", "Monde").then((out) => rapide = out);

    print(lent);
    print(rapide);
  }
  compareAsync3();

  // Solution
  compareAsync4() async {
    var lent;
    var rapide;

    lent = await printAsyncLente("d Hello", "World");
    rapide = await printAsyncRapide("d Salut", "Monde");

    print(lent);
    print(rapide);
  }
  compareAsync4();

  // Better concurrency
  compareAsync5() async {
    var lent = printAsyncLente("e Hello", "World");
    var rapide = printAsyncRapide("e Salut", "Monde");
    var same = await Future.wait([lent, rapide]);
  
    print(same);
  }
  compareAsync5();

  // Error Handling
  // trigger une erreur
  // throw "Erreur"
  // Sync
  funcSyncProvokeError() {
    try{
      String sortie = funcSync();
      if(sortie is! int) throw Exception("Bullshit!");
    } catch(e) {
      print(e);
    }
  }
  funcSyncProvokeError();

  // Async
  funcAsyncProvokeError() async {
    try{
      String sortie = await funcAsync();
      if(sortie is! int) throw Exception("Bullshit 2!");
    } catch(e) {
      print(e);
    }
  }
  funcAsyncProvokeError();

  funcAsync().then((sortie) {
    if(sortie is! int) throw Exception("Bullshit 3!");
  }).catchError(print);

  // Classes
  var person = Person("Scientifique", age: 32);
}

class Person {
  final String soustitre;
  final String nom;
  final String prenom;
  final int age;

  Person(this.soustitre, {this.nom: "Einstein", this.prenom: "Albert", this.age});

  appel() => print("$nom $prenom, $soustitre");
}
