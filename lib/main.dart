import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Row(
            children: [
              DraggableCard(
                color: Colors.green,
              ),
              DraggableCard(
                color: Colors.red,
              ),
              DraggableCard(
                color: Colors.blue,
              ),
            ],
          ),
          DragTargetCard(),
        ],
      ),
    );
  }
}

// ユーザーにドラッグされる側のWidget
class DraggableCard extends StatelessWidget {
  const DraggableCard({super.key, required this.color});

  final MaterialColor color;

  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: color.toString(),
      child: Container(
        width: 100,
        height: 100,
        color: color,
      ),
      feedback: Container(
        width: 100,
        height: 100,
        color: color.withOpacity(0.5),
      ),
      childWhenDragging: Container(
        width: 100,
        height: 100,
        color: color,
      ),
      // ドラッグ開始時に呼ばれる
      onDragStarted: () {
        print('onDragStarted');
      },
      // ドラッグ終了時に呼ばれる
      onDragEnd: (DraggableDetails details) {
        print('onDragEnd - $details');
      },
      // ドラッグがDragTargetで受け入れられた時に呼ばれる
      onDragCompleted: () {
        print('onDragCompleted');
      },
      // ドラッグがキャンセルされた時に呼ばれる
      onDraggableCanceled: (Velocity velocity, Offset offset) {
        print('onDraggableCanceled - velocity:$velocity , offset:$offset');
      },
    );
  }
}

// ユーザーにドロップされる側のWidget
class DragTargetCard extends StatefulWidget {
  DragTargetCard({super.key});

  @override
  State<DragTargetCard> createState() => _DragTargetCardState();
}

class _DragTargetCardState extends State<DragTargetCard> {
  String message = '';

  @override
  Widget build(BuildContext context) {
    return DragTarget(
      builder: (context, accepted, rejected) {
        return Container(
          width: 200,
          height: 200,
          color: Colors.grey,
          child: Text(message),
        );
      },
      // DragTarget の範囲に入った時に呼ばれる
      onWillAccept: (data) {
        print('onWillAccept - $data');
        // ドラッグ操作を受け入れる場合はここでtrueを返す
        setState(() {
          message = '範囲に入ったよ！！！';
        });
        return true;
      },
      // DragTargetにドラッグされた時に呼ばれる
      onAccept: (data) {
        print('onAccept - $data');
        setState(() {
          message = data.toString();
        });
      },
      // DragTarget の範囲から離れた時に呼ばれる
      onLeave: (data) {
        print('onLeave - $data');
        setState(() {
          message = '範囲から離れたよ！！！';
        });
      },
    );
  }
}
