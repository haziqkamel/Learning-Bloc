import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_bloc/cubit/counter_cubit.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, @required this.title, this.color}) : super(key: key);

  final String title;
  final Color color;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> homeScreenKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: widget.color,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            SizedBox(height: 10),
            BlocConsumer<CounterCubit, CounterState>(
              listener: (context, state) {
                // TODO: implement listener
                if (state.wasIncremented == true) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('Incremented!'),
                    duration: Duration(milliseconds: 200),
                  ));
                } else {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('Decremented!'),
                    duration: Duration(milliseconds: 200),
                  ));
                }
              },
              builder: (context, state) {
                // if (state.counterValue < 0) {
                //   return Text(
                //     'Negative Numbers - ' + state.counterValue.toString(),
                //     style: Theme.of(context).textTheme.headline6,
                //   );
                // } else if (state.counterValue % 2 == 0) {
                //   return Text(
                //     'Remainders of 2 - ' + state.counterValue.toString(),
                //     style: Theme.of(context).textTheme.headline6,
                //   );
                // } else
                return Text(
                  state.counterValue.toString(),
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: Text('${widget.title}'),
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).decrement();
                    //context.bloc<CounterCubit>.decrement();
                  },
                  tooltip: 'Decrement',
                  child: Icon(Icons.remove),
                ),
                FloatingActionButton(
                  heroTag: Text('${widget.title} 2nd'),
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).increment();
                  },
                  tooltip: 'Increment',
                  child: Icon(Icons.add),
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed('/second', arguments: homeScreenKey);
              },
              color: Colors.redAccent,
              child: Text('Go to second screen'),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/third');
              },
              color: Colors.greenAccent,
              child: Text('Go to third screen'),
            ),
          ],
        ),
      ),
    );
  }
}
