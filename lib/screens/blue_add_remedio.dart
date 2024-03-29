import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/eva.dart';
import 'package:smart_mhealth_companion/components/button_dialog.dart';
import 'package:smart_mhealth_companion/components/left_text.dart';
import 'package:smart_mhealth_companion/screens/config_alarme.dart';
import 'package:smart_mhealth_companion/themes/color.dart';
import 'package:smart_mhealth_companion/globals.dart' as globals;
import 'package:smart_mhealth_companion/components/barcodescanner.dart';

class CadastrarRemedio extends StatefulWidget {
  const CadastrarRemedio({Key? key}) : super(key: key);

  @override
  State<CadastrarRemedio> createState() => _CadastrarRemedioState();
}

const List<int> listHour = <int>[
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  17,
  18,
  19,
  20,
  21,
  22,
  23
];
const List<int> listMinute = <int>[00, 15, 30, 45];
const id = 0;
const payload = '';

class _CadastrarRemedioState extends State<CadastrarRemedio> {
  TextEditingController nomeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    nomeController.addListener(_checkIfFieldIsEmpty);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _checkIfFieldIsEmpty listener.
    globals.remedioNome = '';
    nomeController.dispose();
    super.dispose();
  }

  _checkIfFieldIsEmpty() {
    if (globals.remedioNome != '') {
      nomeController.text = globals.remedioNome;
      setState(() {});
    }
  }

  int hour = 1;
  int minute = 00;
  BarcodeScanner scan = BarcodeScanner();
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColorLight,
      appBar: AppBar(
        backgroundColor: secondaryColor,
      ),
      body: ListView(
        children: <Widget>[
          Stack(children: [
            const Padding(
                padding: EdgeInsets.only(top: 15, left: 110, right: 71),
                child: CircleAvatar(
                  backgroundImage: AssetImage('lib/assets/exemplo_remedio.png'),
                  radius: 80,
                )),
            const Padding(
                padding: EdgeInsets.only(top: 15, left: 265),
                child: Iconify(Eva.question_mark_circle_fill,
                    color: infoDefault, size: 45)),
            Padding(
              padding: const EdgeInsets.only(top: 130, left: 265),
              child: IconButton(
                  onPressed: () => {scan.scanBarcodeNormal()},
                  icon: const Iconify(Eva.camera_fill,
                      color: infoDefault, size: 45)),
            ),
          ]),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              width: 600,
              height: 100,
              decoration: BoxDecoration(
                color: secondaryColor.withOpacity(0.4),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Stack(children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 40.0, right: 28.0, left: 29.0, bottom: 15.0),
                  child: TextField(
                    keyboardType: TextInputType.name,
                    style: const TextStyle(
                      height: 0.8,
                    ),
                    controller: nomeController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      alignLabelWithHint: false,
                      hintText: 'Ex. Advil',
                      hintStyle: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(top: 2, left: 29),
                      child: LeftTxt(20, FontWeight.w400, 'Nome do Remédio:'),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 1, left: 90),
                        child: Iconify(Eva.question_mark_circle_fill,
                            color: infoDefault, size: 35))
                  ],
                ),
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              width: 600,
              height: 100,
              decoration: BoxDecoration(
                color: secondaryColor.withOpacity(0.4),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Stack(children: [
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(top: 2, left: 29),
                      child: LeftTxt(20, FontWeight.w400, "Horário de inicio"),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 1, left: 90),
                        child: Iconify(Eva.question_mark_circle_fill,
                            color: infoDefault, size: 35))
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 40.0, left: 35.0, bottom: 15.0),
                      child: ElevatedButton(
                        onPressed: () {
                          _selectTime(context);
                        },
                        child: const Text("Selecione a hora"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, left: 16.0),
                      child: Text("${selectedTime.hour}:${selectedTime.minute}",
                          style: const TextStyle(fontSize: 32)),
                    ),
                  ],
                ),
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              width: 600,
              height: 100,
              decoration: BoxDecoration(
                color: secondaryColor.withOpacity(0.4),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Stack(children: [
                Padding(
                    padding: const EdgeInsets.only(
                        top: 40.0, left: 35.0, bottom: 15.0),
                    child: Row(
                      children: [
                        DropdownButton<int>(
                          value: hour,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (int? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              hour = value!;
                            });
                          },
                          items:
                              listHour.map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                        ),
                        DropdownButton<int>(
                          value: minute,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (int? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              minute = value!;
                            });
                          },
                          items: listMinute
                              .map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                        )
                      ],
                    )),
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(top: 2, left: 29),
                      child: LeftTxt(20, FontWeight.w400, 'Frequência:'),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 1, left: 90),
                        child: Iconify(Eva.question_mark_circle_fill,
                            color: infoDefault, size: 35))
                  ],
                ),
              ]),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 10, left: 35, right: 35),
              child: ElevatedButton(
                onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => BtnDialog(
                        accentColorLight,
                        secondaryColor,
                        'Parabéns!',
                        'Você cadastrou o remédio ${nomeController.text} com sucesso!',
                        '',
                        'lib/assets/exemplo_remedio.png',
                        configAlarm(id, nomeController.text, selectedTime,
                            RepeatInterval.daily, payload))),
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryColor,
                  textStyle: TextStyle(
                    fontFamily: GoogleFonts.inter().fontFamily,
                    fontSize: 25,
                  ),
                  minimumSize: const Size(170, 65),
                  maximumSize: const Size(340, 130),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Concluir'),
              )),
        ],
      ),
    );
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {

      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }
}
