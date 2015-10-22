var foo = function() {
  return foo;
};

var bar = foo => foo + 'baz';

foo();
bar();