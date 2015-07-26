(function() {
  console.log('Current time: ' + Date.now());

  var source = Rx.Observable.interval(1000).take(5);
  var hot = source.publish(); // Convert the sequence into a hot sequence
  var subscription1 = hot.subscribe(
    function(x) {
      console.log('Observer 1: onNext: %s', x);
    },
    function(e) {
      console.log('Observer 1: onError: %s', e);
    },
    function() {
      console.log('Observer 1: onCompleted');
    });
  console.log('Current Time after 1st subscription: ' + Date.now());
  
  setTimeout(function() {    
    hot.connect(); // Hot is connected to source and starts pushing value to subscribers
    console.log('Current Time after connect: ' + Date.now());
    setTimeout(function() {
      console.log('Current Time after 2nd subscription: ' + Date.now());
      var subscription2 = hot.subscribe(
        function(x) {
          console.log('Observer 2: onNext: %s', x);
        },
        function(e) {
          console.log('Observer 2: onError: %s', e);
        },
        function() {
          console.log('Observer 2: onCompleted');
        });

    }, 1000);
  }, 1000);
})();
