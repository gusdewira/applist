import 'package:flutter/material.dart';

class ListViewScreen extends StatefulWidget {
  const ListViewScreen({super.key});

  @override
  State<ListViewScreen> createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<ListViewScreen> {
  final input = TextEditingController();
  List<String> hobby = [
    'Menggambar',
    'Menari',
    'Memasak',
    'Bernyanyi',
    'Berenang'
  ];

  void create() {
    String text = input.text;

    //priksa jika text kosong maka set nilai 'no named'
    if (text.trim().isEmpty) {
      text = 'no named';
    }
    hobby.add(text);
    setState(() {});

    //membersihkan input
    input.clear();
  }

  void remove(int index) {
    hobby.removeAt(index);
    setState(() {});
  }

  void update(int index, String value) {
    hobby[index] = value;
    setState(() {});
  }

  void removeAll() {
    hobby.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List View'),
        actions: [
          IconButton(
              onPressed: () {
                removeAll();
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              )),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: hobby.isEmpty
                ? const Center(
                    child: Text('Tidak ada data'),
                  )
                : ListView(
                    children: List.generate(hobby.length, (index) {
                      return Container(
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            border:
                                Border(top: BorderSide(color: Colors.black12))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(child: Text(hobby[index])),
                            Row(
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      //move to form edit
                                      Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FormEditHobbyScreen(
                                                          hobby: hobby[index])))
                                          .then((value) {
                                        if (value != null) {
                                          update(index, value);
                                        }
                                      });
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.edit,
                                      ),
                                    )),
                                GestureDetector(
                                    onTap: () => remove(index),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.delete_forever,
                                        color: Colors.red,
                                      ),
                                    )),
                              ],
                            )
                          ],
                        ),
                      );
                    }),
                  ),
          ),

          //input
          TextField(
            controller: input,
            decoration: const InputDecoration(
              hintText: 'ketik nama hobby ......',
              hintStyle: TextStyle(color: Colors.black45),
              contentPadding: EdgeInsets.all(20),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => create(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

//form edit hobby
class FormEditHobbyScreen extends StatefulWidget {
  final String hobby;
  const FormEditHobbyScreen({super.key, required this.hobby});

  @override
  State<FormEditHobbyScreen> createState() => _FormEditHobbyScreenState();
}

class _FormEditHobbyScreenState extends State<FormEditHobbyScreen> {
  final input = TextEditingController();

  @override
  void initState() {
    input.text = widget.hobby;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Hobby'),
      ),
      body: ListView(
        children: [
          // input
          TextField(
            controller: input,
            decoration: const InputDecoration(
              hintText: 'Ketik nama hobi...',
              hintStyle: TextStyle(color: Colors.black45),
              contentPadding: EdgeInsets.all(20),
            ),
          ),

          // button update
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, input.text);
            },
            child: const Text('Update'),
          )
        ],
      ),
    );
  }
}
