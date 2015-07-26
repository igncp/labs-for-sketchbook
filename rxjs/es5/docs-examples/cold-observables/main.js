(function() {
  var source = Rx.Observable.interval(1000);

  var subscription1 = source.subscribe(
    function(x) {
      console.log('Observer 1: onNext: ' + x);
    },
    function(e) {
      console.log('Observer 1: onError: ' + e.message);
    },
    function() {
      console.log('Observer 1: onCompleted');
    });

  var subscription2 = source.subscribe(
    function(x) {
      console.log('Observer 2: onNext: ' + x);
    },
    function(e) {
      console.log('Observer 2: onError: ' + e.message);
    },
    function() {
      console.log('Observer 2: onCompleted');
    });

  setTimeout(function() {
    subscription1.dispose();
    subscription2.dispose();
  }, 5000);

})();
