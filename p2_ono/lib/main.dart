
import 'package:flutter/material.dart';


class Jogador {
  // Atributos
  String _nome;
  double _numero;
  double _altura;
  double _peso;
  double _envergadura;

  // Construtor
  Jogador(this._numero, this._altura, this._peso, this._envergadura, [this._nome]);
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<Jogador> lista = []; // Lista vazia

  // Construtor
  MyApp() {
    Jogador jogador1 = Jogador(23, 2.06, 113, 2.06, "LeBron James");
    Jogador jogador2 = Jogador(07, 2.08, 109, 2.25, "Kevin Durant");
    lista.add(jogador1);
    lista.add(jogador2);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Jogadores",
      themeMode : ThemeMode.light,
      home: HomePage(lista),
    );
  }
}

class HomePage extends StatefulWidget {
  final List<Jogador> lista;

  // Construtor
  HomePage(this.lista);

  @override
  _HomePageState createState() => _HomePageState(lista);
}

class _HomePageState extends State<HomePage> {
  final List<Jogador> lista;

  // Construtor
  _HomePageState(this.lista);

  // Métodos
  void _atualizarTela() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    return Scaffold( 
      drawer: NavDrawer(lista),
      appBar: AppBar(
        title: Text("Jogadores (${lista.length})"),
      ),
      body: ListView.builder(
          itemCount: lista.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(
                "${lista[index]._nome}",
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () {},
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _atualizarTela,
        tooltip: 'Atualizar',
        child: Icon(Icons.update),
      ),
    );
  }
}

class NavDrawer extends StatelessWidget {
  // Atributos
  final List lista;
  final double _fontSize = 17.0;

  // Construtor
  NavDrawer(this.lista);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // Opcional
          DrawerHeader(
            child: Text(
              "Menu",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(color: Colors.black),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(
              "Informações do Jogador",
              style: TextStyle(fontSize: _fontSize),
            ),
            onTap: () {
              Navigator.pop(context); // Fecha o Drawer
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (contex) => TelaInformacoesJogador(lista),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person_search),
            title: Text(
              "Buscar por um Jogador",
              style: TextStyle(fontSize: _fontSize),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaBuscarPorJogador(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person_add_alt_1_sharp),
            title: Text(
              "Cadastrar um Novo Jogador",
              style: TextStyle(fontSize: _fontSize),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaCadastrarJogador(lista),
                ),
              );
            },
          ),
          Container(
            padding: EdgeInsets.all(20.0),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ListTile(
              leading: Icon(Icons.face),
              title: Text(
                "Sobre",
                style: TextStyle(fontSize: _fontSize),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Sobre(),
                ),
              );
              },
            ),
          ),
        ],
      ),
    );
  }
}

//-----------------------------------------------------------------------------
// Tela Informações do Jogador
//-----------------------------------------------------------------------------

class TelaInformacoesJogador extends StatefulWidget {
  final List<Jogador> lista;

  // Construtor
  TelaInformacoesJogador(this.lista);

  @override
  _TelaInformacoesJogador createState() => _TelaInformacoesJogador(lista);
}

class _TelaInformacoesJogador extends State<TelaInformacoesJogador> {
  // Atributos
  final List lista;
  Jogador jogador;
  int index = -1;
  double _fontSize = 18.0;
  final nomeController = TextEditingController();
  final numeroController = TextEditingController();
  final alturaController = TextEditingController();
  final pesoController = TextEditingController();
  final envergaduraController = TextEditingController();
  bool _edicaoHabilitada = false;

  // Construtor
  _TelaInformacoesJogador(this.lista) {
    if (lista.length > 0) {
      index = 0;
      jogador = lista[0];
      nomeController.text = jogador._nome;
      numeroController.text = jogador._numero.toString();
      alturaController.text = jogador._altura.toString();
      pesoController.text = jogador._peso.toString();
      envergaduraController.text = jogador._envergadura.toString();

    }
  }

  // Métodos
  void _exibirRegistro(index) {
    if (index >= 0 && index < lista.length) {
      this.index = index;
      jogador = lista[index];
      nomeController.text = jogador._nome;
      numeroController.text = jogador._numero.toString();
      alturaController.text = jogador._altura.toString();
      pesoController.text = jogador._peso.toString();
      envergaduraController.text = jogador._envergadura.toString();
      setState(() {});
    }
  }

  void _atualizarDados() {
    if (index >= 0 && index < lista.length) {
      _edicaoHabilitada = false;
      lista[index]._nome = nomeController.text;
      lista[index]._numero = double.parse(numeroController.text);
      lista[index]._peso = double.parse(pesoController.text);
      lista[index]._altura = double.parse(alturaController.text);
      lista[index]._envergadura = double.parse(envergaduraController.text);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var titulo = "Informações do Jogador";
    if (jogador == null) {
      return Scaffold(
        appBar: AppBar(title: Text(titulo)),
        body: Column(
          children: <Widget>[
            Text("Nenhum jogador encontrado!"),
            Container(
              color: Colors.black,
              child: BackButton(),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text(titulo)),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  _edicaoHabilitada = true;
                  setState(() {});
                },
                tooltip: 'Primeiro',
                child: Text("Editar"),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                enabled: _edicaoHabilitada,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nome completo",
                  
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: nomeController,
              ),
            ),
          
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                enabled: _edicaoHabilitada,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Numero",
                  
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: numeroController,
              ),
            ),
           
            Padding(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 20),
              child: TextField(
                enabled: _edicaoHabilitada,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Altura",
                  hintText: "Altura",
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: pesoController,
              ),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 20),
              child: TextField(
                enabled: _edicaoHabilitada,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Peso",
                  hintText: "Peso",
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: pesoController,
              ),
            ),
            
            Padding(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 20),
              child: TextField(
                enabled: _edicaoHabilitada,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Envergadura",
                  hintText: "Envergadura",
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: pesoController,
              ),
            ),

            RaisedButton(
              child: Text(
                "Atualizar Dados",
                style: TextStyle(fontSize: _fontSize),
              ),
              onPressed: _atualizarDados,
            ),
            Text(
              "[${index + 1}/${lista.length}]",
              style: TextStyle(fontSize: 15.0),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <FloatingActionButton>[
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () => _exibirRegistro(0),
                    tooltip: 'Primeiro',
                    child: Icon(Icons.first_page),
                  ),
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () => _exibirRegistro(index - 1),
                    tooltip: 'Primeiro',
                    child: Icon(Icons.navigate_before),
                  ),
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () => _exibirRegistro(index + 1),
                    tooltip: 'Primeiro',
                    child: Icon(Icons.navigate_next),
                  ),
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () => _exibirRegistro(lista.length - 1),
                    tooltip: 'Primeiro',
                    child: Icon(Icons.last_page),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//-----------------------------------------------------------------------------
// Tela: Buscar por Jogador
// ----------------------------------------------------------------------------

class TelaBuscarPorJogador extends StatefulWidget {
  @override
  _TelaBuscarPorJogador createState() => _TelaBuscarPorJogador();
}

class _TelaBuscarPorJogador extends State<TelaBuscarPorJogador> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Buscar por Jogador")),
    );
  }
}

//-----------------------------------------------------------------------------
// Tela: Cadastrar Jogador
// ----------------------------------------------------------------------------

class TelaCadastrarJogador extends StatefulWidget {
  final List<Jogador> lista;

  // Construtor
  TelaCadastrarJogador(this.lista);

  @override
  _TelaCadastrarJogadorState createState() =>_TelaCadastrarJogadorState(lista);
}

class _TelaCadastrarJogadorState extends State<TelaCadastrarJogador> {
  // Atributos
  final List<Jogador> lista;
  String _nome = "";
  double _numero = 0.0;
  double _altura = 0.0;
  double _peso = 0.0;
  double _envergadura = 0.0;
  double _fontSize = 20.0;
  final nomeController = TextEditingController();
  final numeroController = TextEditingController();
  final alturaController = TextEditingController();
  final pesoController = TextEditingController();
  final envergaduraController = TextEditingController();

  // Construtor
  _TelaCadastrarJogadorState(this.lista);

  // Métodos
  void _cadastrarJogador() {
    _nome = nomeController.text;
    _numero = double.parse(numeroController.text);
    _altura = double.parse(alturaController.text);
    _peso = double.parse(pesoController.text);
    _envergadura = double.parse(envergaduraController.text);
    if (_numero > 0 && _altura> 0) {
      var jogador = Jogador(_numero, _altura, _peso, _envergadura, _nome); // Cria um novo objeto
     
      lista.add(jogador);
      
      nomeController.text = "";
      numeroController.text = "";
      alturaController.text = "";
      pesoController.text = "";
      envergaduraController.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar Jogador"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Text(
                "Dados do Jogador:",
                style: TextStyle(fontSize: _fontSize),
              ),
            ),
            // --- Nome do Snekar ---
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nome do jogador",
                  // hintText: "Nome do Jogador",
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: nomeController,
              ),
            ),
            // --Numero Jogador ---
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Numero do jogador",
                  // hintText: 'Numero do Snekaer (kg)',
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: numeroController,
              ),
            ),
            // --- Altura do Jogador ---
            Padding(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 20),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Altura do jogador",
                  hintText: "Altura do jogador",
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: alturaController,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 20),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Peso do jogador",
                  hintText: "Peso do jogador",
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: pesoController,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 20),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Envergadura do jogador",
                  hintText: "Envergadura do jogador",
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: envergaduraController,
              ),
            ),
            RaisedButton(
              child: Text(
                "Cadastrar Jogador",
                style: TextStyle(fontSize: _fontSize),
              ),
              onPressed: _cadastrarJogador,
            ),
          ],
        ),
      ),
    );
  }
}

//-----------------------------------------------------------------------------
// Tela: Sobre
// ----------------------------------------------------------------------------

class Sobre extends StatefulWidget  {
  SobreContext createState() => SobreContext();
}
class SobreContext extends State<Sobre> {
  @override
  Widget build(BuildContext context) {
    var titulo = "Sobre";

    return Scaffold(
      appBar: AppBar(title: Text(titulo)),
      body: Column(
        children: <Widget>[
          Text("William Junio de Souza RA 190008277", 
          style: TextStyle(fontSize: 20.0),),
          Container(height: 20, width: 20),
          Text("Programa cadastra jogador", 
          style: TextStyle(fontSize: 20.0),),
          Container(height: 20, width: 20),
        ],
      ),
    );
  }
}
