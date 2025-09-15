import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _images = [
    "assets/images/bg1.png",
    "assets/images/bg2.jpg",
    "assets/images/bg3.jpg"
  ];

  late final PageController _controller;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _prev() {
    if (_index > 0){
      _controller.previousPage(duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
    }
  }

  void _next() {
    if (_index < _images.length - 1) {
      _controller.nextPage(duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Image.asset("assets/icons/logo1.png"),
        ),
        actions: [
          Row(
            children: [
              SizedBox(
                width: 30,
                height: 30,
                child: Image.asset("assets/icons/language.png", fit: BoxFit.cover)),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 10.0),
                child: IconButton(
                icon: const Icon(Icons.menu, color: Colors.black87),
                onPressed: () => _scaffoldKey.currentState!.openEndDrawer(),
              ),
                
              ),
            ],
          )
        ],
      ),
      endDrawer: Drawer(
        child: SafeArea(
          child: ListView(
            children:  [
              ListTile(leading: Icon(Icons.subject), title: Text("Profile")),
              ListTile(leading: Icon(Icons.info), title: Text("Events")),
              ListTile(leading: Icon(Icons.contact_mail), title: Text("Courses")),
              ListTile(leading: Icon(Icons.info), title: Text("")),
              ListTile(leading: Icon(Icons.contact_mail), title: Text("İletişim")),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: AspectRatio(aspectRatio: 16/9,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: _images.length,
                    onPageChanged: (i) => setState(() {
                      _index = i;
                    }),
                    itemBuilder: (_,i) => Image.asset(
                      _images[i], fit: BoxFit.cover,
                    )
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 0, bottom: 0,
                  child: _CircleButton_left(
                    icon: Icons.chevron_left,
                    onTap: _prev,
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 0, bottom: 0,
                  child: _CircleButton_right(
                    icon: Icons.chevron_right,
                    onTap: _next,
                  ),
                ),
              ],
            ),),
          )
        ],
      )
    );
  }
}

class _CircleButton_right extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _CircleButton_right({required this.icon, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.35),
      shape: const CircleBorder(),
      elevation: 0,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: const SizedBox(
          width: 38, height: 38,
          child: Center(
            child: Icon(Icons.chevron_right, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
class _CircleButton_left extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _CircleButton_left({required this.icon, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.35),
      shape: const CircleBorder(),
      elevation: 0,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: const SizedBox(
          width: 38, height: 38,
          child: Center(
            child: Icon(Icons.chevron_left, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
