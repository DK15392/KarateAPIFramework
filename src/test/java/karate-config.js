function fn() {
  var config = {
    baseUrl: 'https://api.practicesoftwaretesting.com',
    timeout: 30000
  };
  
  karate.configure('connectTimeout', config.timeout);
  karate.configure('readTimeout', config.timeout);
  
  return config;
}
