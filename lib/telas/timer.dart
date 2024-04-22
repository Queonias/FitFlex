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
          tempoTexto = '1';
        }
        // Verifique se o texto é um número válido
        int? tempo = int.tryParse(tempoTexto);
        // Atualize o tempo do relógio com base no novo valor inserido ou defina um valor padrão
        if (tempo == null || tempo <= 0) {
          tempo = 1;
        }
        _clockController.restart(duration: tempo * 60);
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
          _controllerTempo.text.isEmpty ? '60' : _controllerTempo.text),
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
                  child: TextField(
                    controller: _controllerTempo,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Tempo',
                      border: OutlineInputBorder(),
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
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.timesCompleted,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
