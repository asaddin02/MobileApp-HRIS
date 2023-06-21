import 'package:flutter/material.dart';
import 'package:techsolution/service/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techsolution/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class EditPorfilePage extends StatefulWidget {
  const EditPorfilePage({super.key});

  @override
  State<EditPorfilePage> createState() => _EditPorfilePageState();
}

class _EditPorfilePageState extends State<EditPorfilePage> {
  bool isLoading = true;

  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  void showCustomSnackbar(String message) {
    _scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      backgroundColor: const Color.fromARGB(255, 77, 167, 13),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 3000),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: AppTheme.textColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ));
  }

  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  void completeedit() {
    Navigator.popAndPushNamed(context, '/edit-profile');
  }

  handleprofile() async {
    print(controller1.text);
    // var data = {
    //   'nama': controller1.text,
    //   'email': controller2.text,
    //   'nomor_hp': controller3.text
    // };
    // var res = await AuthUser().editData(data);
    // if (res.statusCode == 200) {
    //   showCustomSnackbar('Update succesfully');
    //   completeedit();
    // }
  }

  Map<String, dynamic> userData = {};
  void fetchData() async {
    Map<String, dynamic> user = await AuthUser().getUser();
    setState(() {
      userData = user;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
    fetchData();
  }

  void loadData() {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  Widget header() {
    return AppBar(
      backgroundColor: AppTheme.primaryColor,
      centerTitle: true,
      title: Text(
        "Profile",
        style: GoogleFonts.poppins(
            textStyle: const TextStyle(
                color: AppTheme.textColor,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
      ),
      automaticallyImplyLeading: false,
    );
  }

  Widget leading() {
    return Material(
        type: MaterialType.transparency,
        child: Container(
          margin: const EdgeInsets.only(bottom: 30),
          child: Column(
            children: [
              ClipOval(
                child: Image.asset('assets/profile.png', width: 100),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${userData['user']?['nama'] ?? ''}',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        color: AppTheme.textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${userData['user']?['nik'] ?? ''}',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.textColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  Widget editIcons(String label, String type, String text) {
    return Material(
      type: MaterialType.transparency,
      child: Column(children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(label,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 13,
                  color: AppTheme.textColor,
                  fontWeight: FontWeight.w500,
                ),
              )),
        ),
        const SizedBox(height: 5),
        GestureDetector(
          onTap: () {
            editProfile(label, type, text);
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppTheme.thirdColor,
                borderRadius: BorderRadius.circular(7)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(text,
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 13,
                          color: AppTheme.textColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      overflow: TextOverflow.ellipsis),
                ),
                const Icon(CupertinoIcons.create,
                    color: AppTheme.textColor, size: 16)
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget hintIcons() {
    return IconButton(
        onPressed: () {
          Navigator.pushNamed(context, '/hint-point');
        },
        icon: const Icon(
          CupertinoIcons.info_circle,
          size: 16,
          color: AppTheme.textColor,
        ));
  }

  Widget editProfile(String label, String type, String text) {
    TextEditingController controller = TextEditingController(text: text);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.thirdColor,
          title: Row(
            children: [
              Text(
                type,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 15,
                    color: AppTheme.textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              hintIcons()
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  readOnly: type == 'Immutable Data' ? true : false,
                  controller: controller,
                  onChanged: (label) {
                    // ignore: unrelated_type_equality_checks
                    if (label == "Nama Lengkap :") {
                      setState(() {
                        controller1 = controller;
                      });
                    } else if (label == "Alamat Email :") {
                      setState(() {
                        controller2 = controller;
                      });
                    } else if (label == "Nomor HP :") {
                      setState(() {
                        controller3 = controller;
                      });
                    }
                  },
                  keyboardType: label == 'Nomor HP :'
                      ? TextInputType.number
                      : TextInputType.text,
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                    fontSize: 13,
                    color: AppTheme.textColor,
                    fontWeight: FontWeight.w500,
                  )),
                  decoration: InputDecoration(
                    labelStyle: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                      fontSize: 13,
                      color: AppTheme.textColor,
                      fontWeight: FontWeight.w400,
                    )),
                    labelText: label,
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: type == 'Immutable Data'
                                ? AppTheme.thirdColor
                                : AppTheme.textColor)),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: type == 'Immutable Data'
                              ? AppTheme.thirdColor
                              : AppTheme.secondaryColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                handleprofile();
              },
              child: Text('Save',
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.secondaryColor,
                    fontWeight: FontWeight.w400,
                  ))),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel',
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                    fontSize: 15,
                    color: AppTheme.secondaryColor,
                    fontWeight: FontWeight.w400,
                  ))),
            ),
          ],
        );
      },
    );
    return Container();
  }

  Widget content() {
    List<Map<String, dynamic>> userFields = [
      {
        'label': 'Nama Lengkap :',
        'type': 'Mutable Data',
        'value': userData['user']?['nama'] ?? '',
      },
      {
        'label': 'Alamat Email :',
        'type': 'Mutable Data',
        'value': userData['user']?['email'] ?? '',
      },
      {
        'label': 'Nomor HP :',
        'type': 'Mutable Data',
        'value': userData['user']?['nomor_hp'] ?? '',
      },
      {
        'label': 'Tanggal Lahir :',
        'type': 'Immutable Data',
        'value': DateFormat.yMMMMEEEEd()
            .format(DateTime.parse(userData['user']?['tanggal_lahir'] ?? '')),
      },
      {
        'label': 'Alamat Lengkap :',
        'type': 'Immutable Data',
        'value': userData['user']?['alamat'] ?? '',
      },
      {
        'label': 'Jenis Kelamin :',
        'type': 'Immutable Data',
        'value': userData['user']?['jenis_kelamin'] ?? '',
      },
      {
        'label': 'Departmen :',
        'type': 'Immutable Data',
        'value': userData['user']?['department'] ?? '',
      },
      {
        'label': 'Golongan :',
        'type': 'Immutable Data',
        'value': userData['user']?['golongan'] ?? '',
      },
    ];
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(height: 20),
          ...userFields.map((Map<String, dynamic> field) {
            String label = field['label'];
            String type = field['type'];
            dynamic value = field['value'];
            return GestureDetector(
              onTap: () {},
              child: editIcons(label, type, '$value'),
            );
          }).toList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          return false;
        },
        child: Scaffold(
            backgroundColor: AppTheme.primaryColor,
            body: isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                    color: AppTheme.secondaryColor,
                  ))
                : Column(
                    children: <Widget>[header(), leading(), content()],
                  )));
  }
}
