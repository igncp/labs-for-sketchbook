(function() {
  var source = Rx.Observable.fromEvent(document, 'mousemove');
  var subscription = source.subscribe(function(e) {
    console.log('clientX: %s, clientY: %s', e.clientY, e.clientY);
  });
})();
