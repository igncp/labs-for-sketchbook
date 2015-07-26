(function() {
  Rx.Observable.fromEvent(document, 'mousemove')
    .map(function(e) {
      return {
        x: e.clientX,
        y: e.clientY
      };
    }).filter(function(pos) {
      return Math.abs(pos.x - pos.y) < 20;
    }).subscribe(function(pos) {
      console.log('mouse at ' + pos.x + ', ' + pos.y);
    });
})();
