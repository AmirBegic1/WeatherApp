import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:weather_app/model/Weather_model.dart';

import '../service/WeatherAPI.dart';

class WeatherEvent extends Equatable {
  @override
  List<Object> get props => [];
}

//pokupit sa apija
class fetchWeather extends WeatherEvent {
  final _city;
  fetchWeather(this._city);
  @override
  List<Object> get props => [_city];
}

// za vise gradova
class resetWeather extends WeatherEvent {}

class WeatherState extends Equatable {
  @override
  List<Object> get props => [];
}

class WeatherIsNotSearched extends WeatherState {}

class WeatherIsLoading extends WeatherState {}

class WeatherIsLoaded extends WeatherState {
  final _weather;
  WeatherIsLoaded(this._weather);

  WeatherModel get getWeather => _weather;

  @override
  List<Object> get props => [_weather];
}

class WeatherIsNotLoeaded extends WeatherState {}

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherAPI weatherAPI;
  WeatherBloc(this.weatherAPI) : super(WeatherState()) {
    WeatherIsNotSearched();
  }

  WeatherState get initialState => WeatherIsNotSearched();

  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is fetchWeather) {
      yield WeatherIsLoading();

      try {
        WeatherModel weather = await WeatherAPI().getWeather(event._city);
        yield WeatherIsLoaded(weather);
      } catch (_) {
        yield WeatherIsNotLoeaded();
      }
    } else if (event is resetWeather) {
      yield WeatherIsNotSearched();
    }
  }
}
