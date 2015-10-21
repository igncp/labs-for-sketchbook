var foo = function() {
  return 'baz';
};

var bar = foo => foo + 'baz';

foo();
bar();