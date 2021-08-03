# Bloc Core Concept

1. BlocProvider
2. BlocBuilder
3. BlocListener
4. BlocConsumer
5. BlocRepository

10 or more bloc / repositories?
1. MultiBlockProvider
Example:

MultiBlocProvider(
    providers: [
        BlockProvider<BlocA>{
            create: (BuildContext context) => BlocA(),
        },
        BlockProvider<BlocB>{
            create: (BuildContext context) => BlocB(),
        },
        BlockProvider<BlocV>{
            create: (BuildContext context) => BlocV(),
        },
    ],
    child: ChildA(),
)

2. MultiBlockListener
Example:

MultiBlocListener(
    listeners: [
        BlockListener<BlocA,BlocAState>{
            listener: (context, state) {},
        },
        BlockListener<BlocB,BlocAState>{
            listener: (context, state) {},
        },
        BlockListener<BlocC,BlocAState>{
            listener: (context, state) {},
        },
    ],
    child: ChildA(),
)

3. MultiRepositoryProvider
Example:

MultiRepositoryProvider(
    providers: [
        RepositoryProvider<RepositoryA>{
            create: (context) => RepositoryA(),
        },
        RepositoryProvider<RepositoryB>{
            create: (context) => RepositoryB(),
        },
        RepositoryProvider<RepositoryC>{
            create: (context) => RepositoryC(),
        }
    ],
    child: ChildA(),
)

# Bloc Architecture

UI  (states , events)  => bloc => (request, response) data
Presentation Layer <=> Business Logic Layer <=> Data Layer

## Data Layer (send, retrieve)
1. The models
2. The data providers
3. The repositories

### The models
 - A model is a BLUEPRINT to the DATA your APPLICATION will work with.
Example:

class Weather 
{
    float temperature,
    List<float> forecast,
    List<Icon> icons,
    float windSpeed,
    String cityName,
    ....
}

### Data Provider
 - An API for your app
 Example:

 class WeatherAPI {
     Future<RawWeather> getRawWeather(String city) async {
         RawWeather rawWeather = htt.get('www.accuweather.com/${city}');
         return rawWeather;
     }
 }

 ### Repository
 - Fine tuning raw Weather before sent to business logic layer
 Example:

 class WeatherRepository {
    final WeatherAPI weatherAPI;
    //final OtherWeatherAPI otherWeatherAPI;

    Future<WEather> getWEatherForLocation(String location) async {
        final RawWeather rawWeather = await weatherAPI.getRawWeather(location)

        final Weather weather = Weather.fromJSON(rawWeather);

        return weather;
    }
 }

## Project Repository

lib
    business_logic
        blocs
        cubit
    data
        dataproviders
        models
        repositories
    presentation
        screens
        pages
        widgets
        animations

## Routing
1. Anonymous Routing
2. Named Routing
3. Generated Routing

Notes: It's recommended to decide on a navigation style before starting developing the app, since refactoring the code afterwards can get pretty difficult to execute.

### Anonymous Routing
- providing a bloc/cubit across different anonymous routes
### Named Route Access
- providing an existing instance of bloc/cubit to multiple screens, while navigating with named routes

### Conclusion
1. You can NAVIGATE inside Flutter by using
 a. Anonymous Routing (recommended for SMALL projects)
 b. Named Routing (recommended for MEDIUM projects)
 c. Generated Routing (recommended for LARGE projects)
2. The key is to PROVIDE a UNIQUE INSTANCE of a bloc/cubit. You SHOULDN't create MULTIPLE INSTANCES of the same bloc/cubit.
3. BlocProvider() CREATES & PROVIDES a NEW INSTANCE of a bloc/cubit. BlocProvider.value() takes an ALREADY CREATED INSTANCE and then PROVIDES it further.
4. You can PROVIDE your cubit/bloc INSTANCES
 a. LOCALLY - when you want to provide the instance to A SINGLE SCREEN
 b. SPECIFICALLY - when you want to SPECIFICALLY PROVIDE it acroos 1 or more SCREENS
 c. GLOBALLY - when you want to provide it ACROSS ALL OF YOUR SCREENS

## Bloc to Bloc Communication
1. StreamSubscriptions
2. BlocListener

### BlocListener
Pros
    - It takes care INTERNALLY of all StreamSubscriptions
    - No need to take care of stream/memory leaks anymore
Cons
    - The UI may get cluttered & hard to read with multiple BlocListeners

## BLoc 6.1.0 New Concept
!context.bloc is deprecate

1. context.watch<BlocA>() TRANSLATION
- From the widget that was build within the context BuildContext,
- Start searching for the unique instance of BlocA(), provided aboce in the widget tree, then
- After it's found, watch or "subscribe" to it's stream of emitted states,
- And whenever a new state is emitted by BlocA
- Rebuild the widget from which the lookup was started.

2. context.select replacement for buildWhen

3. context.read()
- is a way to read/access a provided instance of bloc/cubit inside the widget tree
- won't rebuild your widget from where you'll start searching for the bloc/cubit instance
NOTE: context.watch() & context.select() WILL REBUILD it!
- should be called only WHEN you need it, and only where you need it!

THE WAY OF NOT USING context.read
@override
Widget build(BuildContext context) {
    final bloc = context.read<MyBloc>();
    return RaisedButton(
        onPressed: () => bloc.add(MyEvent()),
        ...
    )
}

THE WAY OF USING context.read
@override
Widget build(BuildContext context) {
    return RaisedButton(
        onPressed: () => context.read<MyBloc>.add(MyEvent()),
        ...
    )
}

## Maintaining state with HydratedBloc like SharedPreferences
- Store into AppData (local storage data)

1. CounterCubit and CounterState - HydratedBloc to store counterValue which can be retrieved even after app exit
2. InternetCubit and InternetState - No need HydratedBloc because we want it to be retrieve always to check the connectivity
3. SettingsCubit and SettingsState - HydratedBloc to store boolean True/False for the selected settings which can be retrieved even after app exit

## @override onEvent() vs @override onChanged()

1. onEvent() is a method that is called before a new Event gets dispatched to the stream of Events (can be used to print the Events)
2. onChanged() is a method that is called before a new State gets dispatched to the stream of States (can be used to print the States)

## @override onTransition()
- Combination of onEvent and onChanged

1. OnChange() -> Change {currentState: 0, nextState: 1}
2. onEvent() -> CounterEvent.increment
3. onTransition() -> Transition {currentState: 0, event: CounterEvent.increment, nextState: 1}

## BlocObserver

# Naming Conventions
## THE STATES "Bloc(or Cubit) subject + action + state of the action"
Example:

WeatherBloc = WeatherFetchSuccess -> WeatherFetchInProgress -> WeatherFetchFailure

UserCubit = UserCreateSuccess -> UserCreateInProgress -> UserDeleteFailure -> UserFetchSuccess

## THE EVENTS "Bloc(or Cubit) subject + action(event) in past tense"
Example:

UserBloc = UserFetched -> UserDeleted -> UserCreated -> UserModified

## THE FUNCTIONS "Action on what the cubit is working on"
Example:

UserCubit -> Fetch -> Delete -> Create -> Modify

