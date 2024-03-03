import 'package:client/create_join/create_join_presenter.dart';
import 'package:client/res/outlined_letters.dart';
import 'package:client/res/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateAndJoinPage extends StatefulWidget {
  const CreateAndJoinPage({super.key});

  @override
  State<CreateAndJoinPage> createState() => _CreateAndJoinPageState();
}

class _CreateAndJoinPageState extends State<CreateAndJoinPage> implements CreateAndJoinPageView {

  late CreateAndJoinPagePresenter _presenter;

  int seatNum = -1;

  bool buttonsActive = true;

  @override
  void initState() {
    super.initState();
    _presenter = CreateAndJoinPagePresenter(this);
  }

  Gradient titleGradiant = const LinearGradient(
    colors: [Colors.amber, Colors.orange]
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background.jpg'),
              fit: BoxFit.cover
            )
          ),
          child: Column(
            children: [
              //Used to ensure the background is 100% of the screen
              const SizedBox(width: double.infinity),
              //Title
              ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) => titleGradiant.createShader(
                  Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                ),
                child: const Text(Strings.appTitle,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 100.0,
                    fontFamily: 'Ambroise Firmin'
                  ),
                ),
              ),
              //Subtitle
              ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) => titleGradiant.createShader(
                  Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                ),
                child: const Text(Strings.tagLine,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50.0,
                    fontFamily: 'Handel Gothic D'
                  ),
                ),
              ), 
              //Input Boxes
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
                    child: Column(
                      children: _buildInputColumn()
                    ),
                  ),
                ),
              ),
              //Selection Buttons
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: SizedBox(
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildButtonRow(),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildInputColumn() {
    const TextStyle inputStyle = TextStyle(
      color: Colors.amber,
    );
    const InputDecoration inputDecoration = InputDecoration(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black)
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.amberAccent)
      )
    );
    return [
      const OutlinedLetters(content: Strings.codeInput),
      SizedBox(
        width: 300,
        height: 70,
        child: TextField(
          onChanged: (text) {
            _presenter.saveCode(text);
          },
          inputFormatters: [
            LengthLimitingTextInputFormatter(20)
          ],
          textAlign: TextAlign.center,
          style: inputStyle,
          cursorColor: Colors.amberAccent,
          decoration: inputDecoration,
        ),
      ),
      const OutlinedLetters(content: Strings.passwordInput),
      SizedBox(
        width: 300,
        height: 70,
        child: TextField(
          onChanged: (text) {
            _presenter.savePassword(text);
          },
          inputFormatters: [
            LengthLimitingTextInputFormatter(20)
          ],
          obscureText: true,
          textAlign: TextAlign.center,
          style: inputStyle,
          cursorColor: Colors.amberAccent,
          decoration: inputDecoration,
        ),
      ),
      const OutlinedLetters(content: Strings.playerNumberInput),
      DropdownButton(
        items: const [
          DropdownMenuItem<int>(
            value: -1,
            child: Text('Seat Number')
          ),
          DropdownMenuItem<int>(
            value: 1,
            child: Text('1'),
          ),
          DropdownMenuItem<int>(
            value: 2,
            child: Text('2'),
          ),
          DropdownMenuItem<int>(
            value: 3,
            child: Text('3'),
          ),
          DropdownMenuItem<int>(
            value: 4,
            child: Text('4'),
          ),
          DropdownMenuItem<int>(
            value: 5,
            child: Text('5'),
          ),
          DropdownMenuItem<int>(
            value: 6,
            child: Text('6'),
          ),
        ], 
        onChanged: (onChanged) {
          if(onChanged == null) return;
          _presenter.changeSeatNumber(onChanged);
          setState(() { seatNum = onChanged; });
        },
        hint: const Text('Select Seat'),
        style: const TextStyle(color: Colors.amberAccent),
        value: seatNum,
        dropdownColor: Colors.grey,
      )
    ];
  }

  List<Widget> _buildButtonRow() {
    List<Widget> protoReturn = [
      TextButton(
        onPressed: buttonsActive ? () {
          _presenter.joinGame();
        } : null,
        style: TextButton.styleFrom(
          backgroundColor: Colors.amber,
          disabledBackgroundColor: Colors.grey         
        ),
        child: const Text(Strings.joinGame,
          style: TextStyle(color: Colors.black),
        )
      ),
      TextButton(
        onPressed: buttonsActive ? () {
          _presenter.createGame();
        } : null,
        style: TextButton.styleFrom(
          backgroundColor: Colors.amber,
          disabledBackgroundColor: Colors.grey         
        ),
        child: const Text(Strings.createGame,
          style: TextStyle(color: Colors.black),
        )
      )
    ];
    List<Widget> toReturn = [];
    for(int i = 0; i < protoReturn.length; i++) {
      toReturn.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: protoReturn[i],
        )
      );
    }
    return toReturn;
  }

  @override
  void swapToBoard() {
    Navigator.of(context).pushNamed('/game');
  }

  @override
  void postToast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: const Duration(milliseconds: 1500),
      )
    );
  }

  @override
  void setButtonState(bool state) {
    setState(() {
      buttonsActive = state;
    });
  }
}