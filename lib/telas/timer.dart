import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:academia/utils/countdown_timer.dart';
import 'package:academia/utils/constants.dart';
import 'package:ndialog/ndialog.dart';

class Timer extends StatefulWidget {
  final List<Icon> timesCompleted = [];

  Timer({super.key}) {
    // Initialize times completed dot icons
    for (var i = 0; i < 3; i++) {
      timesCompleted.add(
        const Icon(
          Icons.brightness_1_rounded,
          color: Colors.blueGrey,
          size: 5.0,
        ),
      );
    }
  }

  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  final CountDownController _clockController = CountDownController();
  final TextEditingController _controllerTempo = TextEditingController();
  Icon _clockButton = kPlayClockButton; // Initial value
  bool _isClockStarted = false; // Conditional flag
  int indexTimesCompleted = 0; // Defina a variável aqui

  // Change Clock button icon and controller
  void switchClockActionButton() {
    if (_clockButton == kPlayClockButton) {
      _clockButton = kPauseClockButton;

      if (!_isClockStarted) {
        // Processed on init
        _isClockStarted = true;
        _clockController.start();
      } else {
        // Processed on play
        _clockController.resume();
      }
    } else {
      // Processed on pause
      _clockButton = kPlayClockButton;
      _clockController.pause();
    }
  }

  void handleTimerCompletion() async {
    // Execute a lógica assíncrona fora do setState
    await Future.delayed(Duration.zero);

    // Atualize o estado de forma síncrona dentro do setState
    setState(() {
      widget.timesCompleted[indexTimesCompleted] = const Icon(
        Icons.brightness_1_rounded,
        color: Colors.pink,
        size: 5.0,
      );
      indexTimesCompleted++;
    });

    // Mostrar o diálogo
    await NDialog(
      dialogStyle: DialogStyle(titleDivider: true),
      title: const Text("Tempo Completado"),
      content: const Text("Hora de fazer uma pausa."),
      actions: <Widget>[
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith(
              (states) => const Color.fromARGB(255, 99, 179, 245),
            ),
          ),
          child: const Text("Iniciar uma pausa curta"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    ).show(context);
  }

  @override
  void initState() {
    super.initState();
    // Adicione um listener ao TextEditingController para ouvir as mudanças de texto
    _controllerTempo.addListener(() {
      setState(() {
        // Obtenha o valor do texto do TextEditingController
        String tempoTexto = _controllerTempo.text;
        if (_controllerTempo.text.isEmpty) {
          tempoTexto = '5';
        }
        // Verifique se o texto é um número válido
        int? tempo = int.tryParse(tempoTexto);
        // Atualize o tempo do relógio com base no novo valor inserido ou defina um valor padrão
        if (tempo == null || tempo <= 0) {
          tempo = 1;
        }
        _clockController.restart(duration: tempo);
      });
      _clockButton = kPlayClockButton;
      _clockController.pause();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height / 2;
    final double width = MediaQuery.of(context).size.width / 2;

    CountDownTimer _countDownTimer = CountDownTimer(
      duration: int.parse(
          _controllerTempo.text.isEmpty ? '5' : _controllerTempo.text),
      fillColor: Colors.pink,
      onComplete: handleTimerCompletion,
    );

    CircularCountDownTimer clock = CircularCountDownTimer(
      controller: _clockController,
      isReverseAnimation: true,
      ringColor: const Color(0xff0B0C19),
      height: height,
      width: width,
      autoStart: false,
      duration: _countDownTimer.duration,
      isReverse: true,
      textStyle: const TextStyle(color: Colors.white),
      fillColor: _countDownTimer.fillColor,
      backgroundColor: const Color(0xFF2A2B4D),
      strokeCap: StrokeCap.round,
      onComplete: handleTimerCompletion,
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.headset_off),
        ),
        title: const Text('Tempo'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.alarm_off),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Center(
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 20.0, bottom: 20.0, left: 12.0, right: 12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            'Duração do tempo: 5 segundos',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey, // Cor da borda
                              width: 1.0, // Largura da borda
                            ),
                            borderRadius: BorderRadius.circular(
                                5.0), // Raio do canto da borda
                          ),
                          child: TextField(
                            controller: _controllerTempo,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Defina o tempo em segundos',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(10.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: clock,
                ),
                const Text(
                  kWorkLabel,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.timesCompleted,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            switchClockActionButton();
                          });
                        },
                        child: Container(
                          width: width / 2.5,
                          height: height / 8,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: _clockButton,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _clockController.restart(
                                duration: int.parse(
                                    _controllerTempo.text.isEmpty
                                        ? '5'
                                        : _controllerTempo.text));
                            _clockButton = kPlayClockButton;
                            _clockController.pause();
                          });
                        },
                        child: Container(
                          width: width / 2.5,
                          height: height / 8,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: const Icon(
                            Icons.refresh,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
