class Weather {
  //* by creating this class i created an 'Entity'
  final int id;
  final String cityName;
  final String main;
  final String description;
  final int pressure;
  final double lon;
  final double lat;
  final double wind_speed;
  final double temp;
  final int humitity;
  final double feel;

  Weather(this.id, this.cityName, this.main, this.description, this.pressure,
      this.lat, this.lon, this.wind_speed, this.temp, this.humitity, this.feel);
}
