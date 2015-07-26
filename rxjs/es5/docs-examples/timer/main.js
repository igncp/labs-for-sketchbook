(function() {
  console.log('Current time: ' + Date.now());
  // In miliseconds. delay and interval
  var source = Rx.Observable.timer(1000, 100).timestamp();

  var subscription = source.subscribe(function(x) {
    console.log(x.value + ': ' + x.timestamp);
  });
})();
