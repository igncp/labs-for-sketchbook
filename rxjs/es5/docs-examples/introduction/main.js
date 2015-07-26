var onNextFn = function(x) {
    console.log('onNext: %s', x);
  },
  onErrorFn = function(e) {
    console.log('onError: %s', e.message);
  },
  onCompletedFn = function() {
    console.log('onCompleted');
  },
  logTitle = function(title) {
    console.log('');
    console.log('----------');
    if (title) console.log(title);
    console.log('----------');
    console.log('');
  };

logTitle();

(function() {
  var source = Rx.Observable.range(1, 3);
  var subscription = source.subscribe(onNextFn, onErrorFn, onCompletedFn);
  subscription.dispose();
})();

logTitle();

(function() {
  var source = Rx.Observable.create(function(observer) {
    observer.onNext(42); // Yield a single value and complete
    observer.onCompleted();
    // Any cleanup logic might go here
    return function() {
      console.log('disposed');
    };
  });

  var subscription = source.subscribe(onNextFn, onErrorFn, onCompletedFn);
  subscription.dispose();
})();

logTitle();

(function() {
  var source = Rx.Observable.range(1, 3);
  var observer = Rx.Observer.create(onNextFn, onErrorFn, onCompletedFn);
  var subscription = source.subscribe(observer);
  subscription.dispose();
})();

logTitle('.from(array)');

(function() {
  var array = [1, 'a', {}, 4, null];
  var source = Rx.Observable.from(array).take(3);
  var subscription = source.subscribe(onNextFn, onErrorFn, onCompletedFn);
})();


logTitle('.concat');

(function() {
  var source1 = Rx.Observable.range(1, 3);
  var source2 = Rx.Observable.range(1, 3);

  source1.concat(source2).subscribe(onNextFn);
})();

logTitle('.merge');

(function() {
  var source1 = Rx.Observable.range(1, 3);
  var source2 = Rx.Observable.range(1, 3);

  source1.merge(source2).subscribe(onNextFn);
})();


logTitle('projection .map');

(function() {
  var array = ['Reactive', 'Extensions', 'RxJS'];
  var seqString = Rx.Observable.from(array);
  var seqNum = seqString.map(function(x) {
    return x.length;
  });
  seqNum.subscribe(onNextFn);
})();