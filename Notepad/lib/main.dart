import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notepad/utility/app_color.dart';
import 'package:notepad/utility/app_hex_color.dart';

///function utama untuk return tampilan awal
void main() {
  runApp(const MainPage());
}

/// main page state untuk mengatur route dan costume thema
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isMain = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      ///routing atau jalur yg di atur sesuai page yang ditargetkan
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        ///isMain adalah variabel yang dipanggil untuk mentriger perubhan data dari halaman homepage
        '/': (context) => HomePage(isMain: isMain),
        '/addNotes': (context) => const AddPage(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: AppColor.mainTheme,
          textTheme:
              const TextTheme(bodyText1: TextStyle(color: Colors.black))),
      darkTheme: ThemeData(
        appBarTheme: AppBarTheme(color: AppHexColor('#3C3F41')),
        primarySwatch: AppColor.darkTheme,
      ),

      ///validasi thema yang akan di triger saat tombol switch di tekan
      themeMode: isMain ? ThemeMode.dark : ThemeMode.light,
      // home: HomePage(isMain: isMain),
    );
  }
}

class HomePage extends StatefulWidget {
  ///dibuatkan constructor untuk akses data
  bool? isMain;

  HomePage({Key? key, this.isMain = false}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///validasi untuk triger sesuai thema
      backgroundColor: isSwitched ? AppColor.darkTheme : null,
      appBar: AppBar(
        backgroundColor:
            isSwitched ? AppHexColor('#3C3F41') : AppColor.mainTheme,
        actions: [
          PopupMenuButton(
            offset: const Offset(0, 44),
            color: isSwitched ? AppHexColor('#3C3F41') : AppColor.mainTheme,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            itemBuilder: (context) {
              return <PopupMenuEntry>[
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Dark Mode',
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                      Switch(
                        value: isSwitched,
                        activeColor: Colors.lightBlueAccent,
                        onChanged: (bool value) {
                          ///action untuk triger perubahan yang akan dibaca oleh tindakan tombol switch
                          setState(() {
                            isSwitched = value;
                            widget.isMain = isSwitched;
                            Navigator.pop(context);
                          });
                        },
                      )
                    ],
                  ),
                )
              ];
            },
          )
        ],
        title: const Text('Notepad'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tes Notes',
                  style: TextStyle(
                      fontSize: 16, color: isSwitched ? Colors.white : null),
                ),
                FaIcon(
                  FontAwesomeIcons.bars,
                  color: isSwitched
                      ? AppHexColor('#3C3F41')
                      : Colors.grey.shade400,
                  size: 25,
                ),
              ],
            ),
          ),
          Divider(
            color: AppHexColor('#3C3F41'),
            height: 1,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: isSwitched ? AppHexColor('#3C3F41') : null,
        onPressed: () {
          ///navigator untuk pemindahan tampilan utama/main ke tampilan addNotes, dengan menyertakan argument untuk penangkapan data yang akan dikirim untuk merubah thema addNotes
          Navigator.pushNamed(context, '/addNotes',
              arguments: {'tes': isSwitched});
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class AddPage extends StatefulWidget {
  const AddPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  bool isSwitched = false;
  TextEditingController addController = TextEditingController();

  @override
  void initState() {
    ///melakukan pengambilan data dari argumen yang dikirim saat rebuild tampilan atau pertama kli tampilan di panggil
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ///dibuatkan varibel final dengan cara menggunakan function yang disediakan flutter
      final args = ModalRoute.of(context)!.settings.arguments;

      ///merubah argumen menjadi Map dengan tipe dynamic agar dapat diterima dari argument yang dikirim
      var rows = args as Map<String, dynamic>;

      ///validasi apakaha data yang di tangkap sudah berhasil atau null(kosong)
      if (rows.isNotEmpty) {
        ///memasukan data yang telah didapat ke dalam variabel tes
        var tes = args['tes'];

        ///data yang didapat di set dengan variabel isSwitchet yang telah dibuat untuk triger thema
        setState(() {
          isSwitched = tes;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///willposcope Widget untuk kembali ke halaman sebelumnya, widget ini disesuikan dengan kebutuhan,
    ///karena saya ingin memberi notif menggunakan snackbar saat kembali degan tombol back atau icon back yang ada pda app bar,
    ///maka saya gunakan willpopscope
    return WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          if (addController.text.isNotEmpty) {
            const snackBar = SnackBar(
              width: 180,
              behavior: SnackBarBehavior.floating,
              content: Text('is has been saved the note',
                  style: TextStyle(fontSize: 14)),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          return false;
        },
        child: Scaffold(
          backgroundColor: isSwitched ? AppColor.darkTheme : null,
          appBar: AppBar(
            actions: [
              IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {},
                  icon: const Icon(Icons.share))
            ],
            backgroundColor:
                isSwitched ? AppHexColor('#3C3F41') : AppColor.mainTheme,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              autofocus: true,
              cursorColor: isSwitched ? Colors.white : null,
              controller: addController,
              style: TextStyle(
                  fontSize: 18, color: isSwitched ? Colors.white : null),
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
          ),
        ));
  }
}
