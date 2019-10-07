import 'package:flutter/material.dart';
import 'package:flutter_ui_events/FindEvent.dart';
import 'package:flutter_ui_events/animation/FadeAnimation.dart';
import 'package:page_transition/page_transition.dart';


void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage()
  )
);

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  AnimationController _scaleController;
  Animation<double> _scaleAnimation;

  bool hide = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _scaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300)
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 30.0
    ).animate(_scaleController)..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.push(context, PageTransition(child: FindEvent(), type: PageTransitionType.fade));
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _scaleController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/intro.jpeg'),
            fit: BoxFit.cover
          )
        ),
        child: Container(
          padding: EdgeInsets.all(30),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(.9),
                Colors.black.withOpacity(.6),
                Colors.black.withOpacity(.8),
                Colors.black.withOpacity(.3),
              ]
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FadeAnimation(1, Text("Encontre os melhores locais perto de você para uma boa noite.", 
              style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold, height: 1.1),)),
              SizedBox(height: 30,),
              FadeAnimation(1.2, Text("Vamos encontrar um evento para seu interesse ", 
              style: TextStyle(color: Colors.white.withOpacity(.7), fontSize: 25, fontWeight: FontWeight.w100),)),
              SizedBox(height: 150,),
              FadeAnimation(1.4, InkWell(
                onTap: () {
                  setState(() {
                    hide = true;
                  });
                  _scaleController.forward();
                },
                child: AnimatedBuilder(
                  animation: _scaleController,
                  builder: (context, child) => Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.yellow[700]
                      ),
                      child: hide == false ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text("Encontre o evento mais próximo", style: TextStyle(color: Colors.white, fontSize: 17),),
                          Icon(Icons.arrow_forward, color: Colors.white,)
                        ],
                      ) : Container(),
                    ),
                  )
                ),
              )),
              SizedBox(height: 60,)
            ],
          ),
        ),
      ),
    );
  }
}