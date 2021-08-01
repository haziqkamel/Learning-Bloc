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

