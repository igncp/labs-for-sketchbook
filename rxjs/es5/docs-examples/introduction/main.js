(function() {
    // Creates an observable sequence of 5 integers, starting from 1
    var source = Rx.Observable.range(1, 5);

    // Prints out each item
    var subscription = source.subscribe(
        function(x) {
            console.log('onNext: ' + x);
        },
        function(e) {
            console.log('onError: ' + e.message);
        },
        function() {
            console.log('onCompleted');
        });

    // => onNext: 1
    // => onNext: 2
    // => onNext: 3
    // => onNext: 4
    // => onNext: 5
    // => onCompleted
    
    console.log("source", source);
    console.log("subscription", subscription);
})();
