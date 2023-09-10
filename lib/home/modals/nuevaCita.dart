import 'package:flutter/material.dart';

class NuevaCita extends StatefulWidget {
  const NuevaCita({super.key});

  @override
  State<NuevaCita> createState() {
    return _NuevaCitaState();
  }
}

class _NuevaCitaState extends State<NuevaCita> {
  // Controladores para los campos del formulario
  final TextEditingController fechaController = TextEditingController();
  final TextEditingController horaController = TextEditingController();
  String selectedOption1 = 'Andrea';
  String selectedOption2 = 'Corte dama';

  @override
  void dispose() {
    fechaController.dispose();
    horaController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text('Ingrese una fecha:'),
            TextFormField(
              controller: fechaController,
              onTap: () async {
                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (selectedDate != null) {
                  fechaController.text =
                      "${selectedDate.toLocal()}".split(' ')[0];
                }
              },
              readOnly: true,
              decoration: const InputDecoration(
                hintText: 'Seleccione una fecha',
                prefixIcon: Icon(Icons.calendar_today),
              ),
            ),
            const SizedBox(height: 16.0),
            const Text('Ingrese una hora:'),
            TextFormField(
              controller: horaController,
              onTap: () async {
                TimeOfDay? selectedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (selectedTime != null) {
                  horaController.text = selectedTime.format(context);
                }
              },
              readOnly: true,
              decoration: const InputDecoration(
                hintText: 'Seleccione una hora',
                prefixIcon: Icon(Icons.access_time),
              ),
            ),
            const SizedBox(height: 16.0),
            const Text('Seleccione un estilista:'),
            DropdownButton<String>(
              value: selectedOption1,
              onChanged: (String? newValue) {
                setState(() {
                  selectedOption1 = newValue!;
                });
              },
              items: <String>['Andrea', 'Camila', 'Marcela', 'William']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 16.0),
            const Text('Seleccione un servicio:'),
            DropdownButton<String>(
              value: selectedOption2,
              onChanged: (String? newValue) {
                setState(() {
                  selectedOption2 = newValue!;
                });
              },
              items: <String>[
                'Corte dama',
                'Chocolaterapia',
                'Uñas',
                'Corte caballero'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.purple),
                elevation: MaterialStatePropertyAll(8),
              ),
              onPressed: () {
                //  TODO
              },
              child: const Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}

void modalNuevaCita(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const NuevaCita();
      });
}
