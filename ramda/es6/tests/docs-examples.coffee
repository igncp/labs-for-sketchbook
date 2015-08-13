NOOP = ()-> undefined

describe 'docs examples', ->
  it 'add: sums numbers', ->
    expect(R.add(2, 3)).to.equal(5)
    expect(R.add(7)(10)).to.equal(17)
  
  it 'addIndex: Creates a new list iteration function from an existing one by adding two new parameters to its callback function', ->
    mapIndexed = R.addIndex R.map
    newArr = mapIndexed ((val, idx)-> idx + '-' + val), ['f', 'o', 'o', 'b', 'a', 'r']
    expect(newArr).to.eql ['0-f', '1-o', '2-o', '3-b', '4-a', '5-r']
  
  it 'adjust: Applies a function to the value at the given index of an array, returning a new copy of the array with the element at the given index replaced with the result of the function application', ->
    expectedResult = [0, 11, 2]
    resultA = R.adjust(R.add(10), 1, [0, 1, 2])
    resultB = R.adjust(R.add(10))(1)([0, 1, 2])
    expect(expectedResult).to.eql(resultA).and.to.eql(resultB)

  it "all: Returns true if all elements of the list match the predicate, false if there are any that don't", ->
    lessThan2 = R.flip(R.lt)(2)
    lessThan3 = R.flip(R.lt)(3)
    resultA = R.all(lessThan2)([1, 2])
    resultB = R.all(lessThan3)([1, 2])
    expect(resultA).to.equal false
    expect(resultB).to.equal true

  it 'allPass: Given a list of predicates, returns a new predicate that will be true exactly when all of them are', ->
    gt10 = (x)-> x > 10
    even = (x)-> x % 2 is 0
    f = R.allPass([gt10, even])
    expect(f(11)).to.equal(false)
    expect(f(12)).to.equal(true)

  it 'always: Returns a function that always returns the given value', ->
    t = R.always 'Tee'
    expect(t()).to.equal('Tee')
    expect(t('foo', 'bar')).to.equal('Tee')

  it "and: A function that returns the first argument if it's falsy otherwise the second argument", ->
    expect(R.and(false, true)).to.equal(false)
    expect(R.and(true, 0)).to.equal(0)
    expect(R.and(null, '')).to.equal(null)

  it 'any: Returns true if at least one of elements of the list match the predicate, false otherwise.', ->
    lessThan0 = R.flip(R.lt)(0)
    lessThan2 = R.flip(R.lt)(2)
    expect(R.any(lessThan0)([1, 2])).to.be.false
    expect(R.any(lessThan2)([1, 2])).to.be.true

  it 'anyPass: Given a list of predicates returns a new predicate that will be true exactly when any one of them is', ->
    gt10 = (x)-> x > 10
    even = (x)-> x % 2 is 0
    f = R.anyPass [gt10, even]
    expect(f(11)).to.be.true
    expect(f(8)).to.be.true
    expect(f(9)).to.be.false

  it 'ap: applies a list of functions to a list of values', ->
    result = R.ap([R.multiply(2), R.add(3)], [1,2,3])
    expect(result).to.eql [2, 4, 6, 4, 5, 6]

  it 'aperture: Returns a new list, composed of n-tuples of consecutive elements If n is greater than the length of the list, an empty list is returned.', ->
    expect(R.aperture(2, [1, 2, 3, 4, 5])).to.eql [[1, 2], [2, 3], [3, 4], [4, 5]]
    expect(R.aperture(3, [1, 2, 3, 4, 5])).to.eql [[1, 2, 3], [2, 3, 4], [3, 4, 5]]
    expect(R.aperture(7, [1, 2, 3, 4, 5])).to.eql []

  it 'append: Returns a new list containing the contents of the given list, followed by the given element.', ->
    expect(R.append('tests', ['write', 'more'])).to.eql ['write', 'more', 'tests']
    expect(R.append('tests', [])).to.eql ['tests']
    expect(R.append(['tests'], ['write', 'more'])).to.eql ['write', 'more', ['tests']]

  it 'apply: Applies function fn to the argument list args. This is useful for creating a fixed-arity function from a variadic function. fn should be a bound function if context is significant.', ->
    nums = [1, 2, 3, -99, 42, 6, 7]
    expect(R.apply(Math.max, nums)).to.equal 42

  it 'assoc: Makes a shallow clone of an object, setting or overriding the specified property with the given value. Note that this copies and flattens prototype properties onto the new object as well. All non-primitive properties are copied by reference.', ->
    newObj = R.assoc('c', 3, {a: 1, b: 2})
    expect(newObj).to.eql({a: 1, b: 2, c: 3})

  it 'assocPath: Makes a shallow clone of an object, setting or overriding the nodes required to create the given path, and placing the specific value at the tail end of that path. Note that this copies and flattens prototype properties onto the new object as well. All non-primitive properties are copied by reference.', ->
    newObj = R.assocPath(['a', 'b', 'c'], 42, {a: {b: {c: 0}}})
    expect(newObj).to.eql({a: {b: {c: 42}}})

  it 'binary: Wraps a function of any arity (including nullary) in a function that accepts exactly 2 parameters. Any extraneous parameters will not be passed to the supplied function.', ->
    takesThreeArgs = (a, b, c)-> [a, b, c]
    takesTwoArgs = R.binary(takesThreeArgs)
    result =  takesTwoArgs(1, 2, 3)
    expect(result).to.eql([1, 2, undefined])

  it 'bind: Creates a function that is bound to a context. Note: R.bind does not provide the additional argument-binding capabilities of Function.prototype.bind.', ->
    fooFn = ()-> expect(this).to.eql({foo: 'bar'})
    barFn = R.bind(fooFn, {foo: 'bar'})
    barFn()

  it 'both: A function wrapping calls to the two functions in an && operation, returning the result of the first function if it is false-y and the result of the second function otherwise. Note that this is short-circuited, meaning that the second function will not be invoked if the first returns a false-y value.', ->
    gt10 = (x)-> x > 10
    even = (x)-> x % 2 is 0
    f = R.both(gt10, even)
    expect(f(100)).to.be.true
    expect(f(101)).to.be.false

  it 'call: Returns the result of calling its first argument with the remaining arguments. This is occasionally useful as a converging function for R.converge: the left branch can produce a function while the right branch produces a value to be passed to that function as an argument.', ->
    indentN = R.pipe(R.times(R.always(' ')), R.join(''), R.replace(/^(?!$)/gm))
    format = R.converge(R.call, R.pipe(R.prop('indent'), indentN), R.prop('value'))
    result = format({indent: 2, value: 'foo\nbar\nbaz\n'})
    expect(result).to.equal '  foo\n  bar\n  baz\n'

  it 'chain: chain maps a function over a list and concatenates the results. This implementation is compatible with the Fantasy-land Chain spec, and will work with types that implement that spec. chain is also known as flatMap in some libraries', ->
    duplicate = (n)-> [n, n]
    result = R.chain(duplicate, [1, 2, 3])
    expect(result).to.eql([1, 1, 2, 2, 3, 3])

  it 'clone: Creates a deep copy of the value which may contain (nested) Arrays and Objects, Numbers, Strings, Booleans and Dates. Functions are not copied, but assigned by their reference.', ->
    objects = [{}, {}, {}]
    objectsClone = R.clone(objects)
    expect(objects[0] is objectsClone[0]).to.be.false

  it 'commute: Turns a list of Functors into a Functor of a list.', ->
    R.commute(R.of, [[1], [2, 3]])   #=> [[1, 2], [1.1, 3]]
    R.commute(R.of, [[1, 2], [3]])   #=> [[1, 3], [2, 3]]
    R.commute(R.of, [[1], [2], [3]]) #=> [[1, 2, 3]]

  xit 'commuteMap: Turns a list of Functors into a Functor of a list, applying a mapping function to the elements of the list along the way.', ->
    R.commuteMap(R.map(R.add(10)), R.of, [[1], [2, 3]])   #=> [[11, 12], [11, 13]]
    R.commuteMap(R.map(R.add(10)), R.of, [[1, 2], [3]])   #=> [[11, 13], [12, 13]]
    R.commuteMap(R.map(R.add(10)), R.of, [[1], [2], [3]]) #=> [[11, 12, 13]]

  it 'comparator: Makes a comparator function out of a function that reports whether the first element is less than the second.', ->
    cmp = R.comparator((a, b)-> a.age < b.age )
    people = [{age: 30}, {age: 26}]
    expect(R.sort(cmp, people)).to.eql([{age: 26}, {age: 30}])

  it 'complement: Takes a function f and returns a function g such that [...]', ->
    isEven = (n)-> n % 2 is 0
    isOdd = R.complement(isEven)
    expect(isOdd(21)).to.be.true
    expect(isOdd(42)).to.be.false

  it 'compose: Performs right-to-left function composition. The rightmost function may have any arity the remaining functions must be unary.', ->
    f = R.compose(R.inc, R.negate, Math.pow)
    expect(f(3, 4)).to.equal(-Math.pow(3,4) + 1)

  xit 'composeK: Returns the right-to-left Kleisli composition of the provided functions, each of which must return a value of a type supported by chain.', ->
    getStateCode = R.composeK(
      R.compose(Maybe.of, R.toUpper),
      get('state'),
      get('address'),
      get('user'),
      parseJson
    )

    getStateCode(Maybe.of('{"user":{"address":{"state":"ny"}}}'))
    #=> Just('NY')
    getStateCode(Maybe.of('[Invalid JSON]'))
    #=> Nothing()

  xit 'composeP: Performs right-to-left composition of one or more Promise-returning functions. The rightmost function may have any arity the remaining functions must be unary.', ->
    #  followersForUser :: String -> Promise [User]
    followersForUser = R.composeP(db.getFollowers, db.getUserById)

  it 'concat: Returns a new list consisting of the elements of the first list followed by the elements of the second.', ->
    expect(R.concat([], [])).to.eql([])
    expect(R.concat([4, 5, 6], [1, 2, 3])).to.eql([4, 5, 6, 1, 2, 3])
    expect(R.concat('ABC', 'DEF')).to.eql('ABCDEF')

  it 'cond: Returns a function, fn, which encapsulates if/else-if/else logic. R.cond takes a list of [predicate, transform] pairs. All of the arguments to fn are applied to each of the predicates in turn until one returns a "truthy" value, at which point fn returns the result of applying its arguments to the corresponding transformer. If none of the predicates matches, fn returns undefined.', ->
    fn = R.cond([
      [R.equals(0),   R.always('water freezes at 0°C')],
      [R.equals(100), R.always('water boils at 100°C')],
      [R.T, (temp)-> 'nothing special happens at ' + temp + '°C']
    ])
    expect(fn(0)).to.equal('water freezes at 0°C')
    expect(fn(50)).to.equal('nothing special happens at 50°C')
    expect(fn(100)).to.equal('water boils at 100°C')

  it 'construct: Wraps a constructor function inside a curried function that can be called with the same arguments and returns the same type.', ->
    # Constructor function
    Widget = (config)-> null
    configs = [{a: 'foo'}, {a: 'bar'}]
    widgets = R.map(R.construct(Widget), configs)
    R.map ((widget)-> expect(widget instanceof Widget).to.be.true), widgets

  xit 'constructN: Wraps a constructor function inside a curried function that can be called with the same arguments and returns the same type. The arity of the function returned is specified to allow using variadic constructor functions.', ->
    # Variadic constructor function
    Widget = ()->
      this.children = Array.prototype.slice.call(arguments)
      # ...
    Widget.prototype = {
      # ...
    }
    allConfigs = [
      # ...
    ]
    R.map(R.constructN(1, Widget), allConfigs) # a list of Widgets

  it 'contains: Returns true if the specified value is equal, in R.equals terms, to at least one element of the given list false otherwise.', ->
    expect(R.contains(3, [1, 2, 3])).to.be.true
    expect(R.contains(4, [1, 2, 3])).to.be.false
    expect(R.contains([42], [[42]])).to.be.true

  it 'containsWith: Returns true if the x is found in the list, using pred as an equality predicate for x.', ->
    xs = [{x: 12}, {x: 11}, {x: 10}]
    expect(R.containsWith(((a, b)-> a.x < b.x), {x: 1}, xs)).to.be.true

  it 'converge: Accepts at least three functions and returns a new function. When invoked, this new function will invoke the first function, after, passing as its arguments the results of invoking the subsequent functions with whatever arguments are passed to the new function.', ->
    add = (a, b)-> a + b
    multiply = (a, b)-> a * b
    subtract = (a, b)-> a - b

    expect(R.converge(multiply, add, subtract)(1, 2)).to.equal((1 + 2) * (1 - 2))

    add3 = (a, b, c)-> a + b + c
    expect(R.converge(add3, multiply, add, subtract)(1, 2)).to.equal((1-2) + (1+2) + (1*2))

  it 'countBy: Counts the elements of a list according to how many match each value of a key generated by the supplied function. Returns an object mapping the keys produced by fn to the number of occurrences in the list. Note that all keys are coerced to strings because of how JavaScript objects work.', ->
    numbers = [1.0, 1.1, 1.2, 2.0, 3.0, 2.2]
    letters = R.split('', 'abcABCaaaBBc')
    expect(R.countBy(Math.floor)(numbers)).to.eql({'1': 3, '2': 2, '3': 1})
    expect(R.countBy(R.toLower)(letters)).to.eql({'a': 5, 'b': 4, 'c': 3})

  xit 'createMapEntry: Creates an object containing a single key:value pair.', ->
    matchPhrases = R.compose(
      R.createMapEntry('must'),
      R.map(R.createMapEntry('match_phrase'))
    )
    matchPhrases(['foo', 'bar', 'baz']) #=> {must: [{match_phrase: 'foo'}, {match_phrase: 'bar'}, {match_phrase: 'baz'}]}

  it "curry: Returns a curried equivalent of the provided function. The curried function has two unusual capabilities. First, its arguments needn't be provided one at a time. If f is a ternary function and g is R.curry(f), the following are equivalent: [...]", ->
    addFourNumbers = (a, b, c, d)-> a + b + c + d

    curriedAddFourNumbers = R.curry(addFourNumbers)
    f = curriedAddFourNumbers(1, 2)
    g = f(3)
    expect(g(4)).to.equal(10)

  xit "curryN: Returns a curried equivalent of the provided function, with the specified arity. The curried function has two unusual capabilities. First, its arguments needn't be provided one at a time. If g is R.curryN(3, f), the following are equivalent:", ->
    addFourNumbers = ()-> R.sum([].slice.call(arguments, 0, 4))

    curriedAddFourNumbers = R.curryN(4, addFourNumbers)
    f = curriedAddFourNumbers(1, 2)
    g = f(3)
    g(4) #=> 10

  it 'dec: Decrements its argument.', ->
    expect(R.dec(42)).to.equal(41)

  it 'defaultTo: Returns the second argument if it is not null or undefined. If it is null or undefined, the first (default) argument is returned.', ->
    defaultTo42 = R.defaultTo(42)

    expect(defaultTo42(null)).to.equal(42)
    expect(defaultTo42(undefined)).to.equal(42)
    expect(defaultTo42('Ramda')).to.equal('Ramda')

  it 'difference: Finds the set (i.e. no duplicates) of all elements in the first list not contained in the second list.', ->
    expect(R.difference([1,2,3,4], [7,6,5,4,3])).to.eql([1,2])
    expect(R.difference([7,6,5,4,3], [1,2,3,4])).to.eql([7,6,5])

  it 'differenceWith: Finds the set (i.e. no duplicates) of all elements in the first list not contained in the second list. Duplication is determined according to the value returned by applying the supplied predicate to two list elements.', ->
    cmp = (x, y)-> x.a is y.a
    l1 = [{a: 1}, {a: 2}, {a: 3}]
    l2 = [{a: 3}, {a: 4}]
    expect(R.differenceWith(cmp, l1, l2)).to.eql([{a: 1}, {a: 2}])

  it 'dissoc: Returns a new object that does not contain a prop property.', ->
    expect(R.dissoc('b', {a: 1, b: 2, c: 3})).to.eql({a: 1, c: 3})

  it 'dissocPath: Makes a shallow clone of an object, omitting the property at the given path. Note that this copies and flattens prototype properties onto the new object as well. All non-primitive properties are copied by reference.', ->
    expect(R.dissocPath(['a', 'b', 'c'], {a: {b: {c: 42}}})).to.eql({a: {b: {}}})

  it 'divide: Divides two numbers. Equivalent to a / b.', ->
    expect(R.divide(71, 100)).to.equal(0.71)
    half = R.divide(R.__, 2)
    expect(half(42)).to.equal(21)
    reciprocal = R.divide(1)
    expect(reciprocal(4)).to.equal(0.25)

  xit 'drop: Returns all but the first n elements of the given list, string, or transducer/transformer (or object with a drop method).', ->
    R.drop(1, ['foo', 'bar', 'baz']) #=> ['bar', 'baz']
    R.drop(2, ['foo', 'bar', 'baz']) #=> ['baz']
    R.drop(3, ['foo', 'bar', 'baz']) #=> []
    R.drop(4, ['foo', 'bar', 'baz']) #=> []
    R.drop(3, 'ramda')               #=> 'da'

  xit 'dropLast: Returns a list containing all but the last n elements of the given list.', ->
    R.dropLast(1, ['foo', 'bar', 'baz']) #=> ['foo', 'bar']
    R.dropLast(2, ['foo', 'bar', 'baz']) #=> ['foo']
    R.dropLast(3, ['foo', 'bar', 'baz']) #=> []
    R.dropLast(4, ['foo', 'bar', 'baz']) #=> []
    R.dropLast(3, 'ramda')               #=> 'ra'

  xit 'dropLastWhile: Returns a new list containing all but last then elements of a given list, passing each value from the right to the supplied predicate function, skipping elements while the predicate function returns true. The predicate function is passed one argument: (value)*.', ->
    lteThree = (x) x <= 3
    R.dropLastWhile(lteThree, [1, 2, 3, 4, 3, 2, 1]) #=> [1, 2]

  xit 'dropRepeats: Returns a new list without any consecutively repeating elements. R.equals is used to determine equality.', ->
    R.dropRepeats([1, 1, 1, 2, 3, 4, 4, 2, 2]) #=> [1, 2, 3, 4, 2]

  xit 'dropRepeatsWith: Returns a new list without any consecutively repeating elements. Equality is determined by applying the supplied predicate two consecutive elements. The first element in a series of equal element is the one being preserved.', ->
    lengthEq = (x, y)-> Math.abs(x) is Math.abs(y)
    l = [1, -1, 1, 3, 4, -4, -4, -5, 5, 3, 3]
    R.dropRepeatsWith(lengthEq, l) #=> [1, 3, 4, -5, 3]

  xit 'dropWhile: Returns a new list containing the last n elements of a given list, passing each value to the supplied predicate function, skipping elements while the predicate function returns true. The predicate function is passed one argument: (value).', ->
    lteTwo = (x)-> x <= 2

    R.dropWhile(lteTwo, [1, 2, 3, 4, 3, 2, 1]) #=> [3, 4, 3, 2, 1]

  xit 'either: A function wrapping calls to the two functions in an || operation, returning the result of the first function if xit is truth-y and the result of the second function otherwise. Note that this is short-circuited, meaning that the second function will not be invoked if the first returns a truth-y value.', ->
    gt10 = (x)-> x > 10
    even = (x)-> x % 2 is 0
    f = R.either(gt10, even)
    f(101) #=> true
    f(8) #=> true

  xit "empty: Returns the empty value of its argument's type. Ramda defines the empty value of Array ([]), Object ({}), and String (''). Other types are supported if they define <Type>.empty and/or <Type>.prototype.empty.", ->
    R.empty(Just(42))      #=> Nothing()
    R.empty([1, 2, 3])     #=> []
    R.empty('unicorns')    #=> ''
    R.empty({x: 1, y: 2})  #=> {}

  xit 'eqProps: Reports whether two objects have the same value, in R.equals terms, for the specified property. Useful as a curried predicate.', ->
    o1 = { a: 1, b: 2, c: 3, d: 4 }
    o2 = { a: 10, b: 20, c: 3, d: 40 }
    R.eqProps('a', o1, o2) #=> false
    R.eqProps('c', o1, o2) #=> true

  xit 'equals: Returns true if its arguments are equivalent, false otherwise. Dispatches to an equals method if present. Handles cyclical data structures.', ->
    R.equals(1, 1) #=> true
    R.equals(1, '1') #=> false
    R.equals([1, 2, 3], [1, 2, 3]) #=> true
    a = {}; a.v = a
    b = {}; b.v = b
    R.equals(a, b) #=> true

  xit 'evolve: Creates a new object by recursively evolving a shallow copy of object, according to the transformation functions. All non-primitive properties are copied by reference.', ->
    tomato  = {firstName: '  Tomato ', data: {elapsed: 100, remaining: 1400}, id:123}
    transformations = {
      firstName: R.trim,
      lastName: R.trim, # Will not get invoked.
      data: {elapsed: R.add(1), remaining: R.add(-1)}
    }
    R.evolve(transformations, tomato) #=> {firstName: 'Tomato', data: {elapsed: 101, remaining: 1399}, id:123}

  xit 'F: A function that always returns false. Any passed in parameters are ignored.', ->
    R.F() #=> false

  xit 'filter: Returns a new list containing only those items that match a given predicate function. The predicate function is passed one argument: (value).', ->
    isEven = (n)-> n % 2 is 0
    R.filter(isEven, [1, 2, 3, 4]) #=> [2, 4]

  xit 'find: Returns the first element of the list which matches the predicate, or undefined if no element matches.', ->
    xs = [{a: 1}, {a: 2}, {a: 3}]
    R.find(R.propEq('a', 2))(xs) #=> {a: 2}
    R.find(R.propEq('a', 4))(xs) #=> undefined

  xit 'findIndex: Returns the index of the first element of the list which matches the predicate, or -1 if no element matches.', ->
    xs = [{a: 1}, {a: 2}, {a: 3}]
    R.findIndex(R.propEq('a', 2))(xs) #=> 1
    R.findIndex(R.propEq('a', 4))(xs) #=> -1

  xit 'findLast: Returns the last element of the list which matches the predicate, or undefined if no element matches.', ->
    xs = [{a: 1, b: 0}, {a:1, b: 1}]
    R.findLast(R.propEq('a', 1))(xs) #=> {a: 1, b: 1}
    R.findLast(R.propEq('a', 4))(xs) #=> undefined

  xit 'findLastIndex: Returns the index of the last element of the list which matches the predicate, or -1 if no element matches.', ->
    xs = [{a: 1, b: 0}, {a:1, b: 1}]
    R.findLastIndex(R.propEq('a', 1))(xs) #=> 1
    R.findLastIndex(R.propEq('a', 4))(xs) #=> -1

  xit 'flatten: Returns a new list by pulling every item out of xit (and all its sub-arrays) and putting them in a new array, depth-first.', ->
    R.flatten([1, 2, [3, 4], 5, [6, [7, 8, [9, [10, 11], 12]]]])
    #=> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

  xit "flip: Returns a new function much like the supplied one, except that the first two arguments' order is reversed.", ->
    mergeThree = (a, b, c)-> ([]).concat(a, b, c)
    mergeThree(1, 2, 3) #=> [1, 2, 3]

    R.flip(mergeThree)(1, 2, 3) #=> [2, 1, 3]

  xit 'forEach: Iterate over an input list, calling a provided function fn for each element in the list.', ->
    printXPlusFive = (x)-> console.log(x + 5)
    R.forEach(printXPlusFive, [1, 2, 3]) #=> [1, 2, 3]
    #-> 6
    #-> 7
    #-> 8

  xit 'fromPairs: Creates a new object out of a list key-value pairs.', ->
    R.fromPairs([['a', 1], ['b', 2],  ['c', 3]]) #=> {a: 1, b: 2, c: 3}

  xit "functions: Returns a list of function names of object's own functions", ->
    R.functions(R) # returns list of ramda's own function names
    F = (()-> this.x = NOOP; this.y = NOOP)
    F.prototype.z = NOOP
    F.prototype.a = 100
    R.functions(new F()) #=> ["x"]

  xit "functionsIn: Returns a list of function names of object's own and prototype functions", ->
    R.functionsIn(R) # returns list of ramda's own and prototype function names
    F = (()-> this.x = NOOP;  this.y = 1)
    F.prototype.z = NOOP
    F.prototype.a = 100
    R.functionsIn(new F()) #=> ["x", "z"]

  xit 'groupBy: Splits a list into sub-lists stored in an object, based on the result of calling a String-returning function on each element, and grouping the results according to values returned.', ->
    byGrade = R.groupBy((student)->
      score = student.score
      return if score < 65 then 'F' else
        if score < 70 then 'D' else
        if score < 80 then 'C' else
        if score < 90 then 'B' else 'A'
    )
    students = [{name: 'Abby', score: 84},
                    {name: 'Eddy', score: 58},
                    # ...
                    {name: 'Jack', score: 69}]
    byGrade(students)

  xit 'gt: Returns true if the first argument is greater than the second false otherwise.', ->
    R.gt(2, 1) #=> true
    R.gt(2, 2) #=> false
    R.gt(2, 3) #=> false
    R.gt('a', 'z') #=> false
    R.gt('z', 'a') #=> true

  xit 'gte: Returns true if the first argument is greater than or equal to the second false otherwise.', ->
    R.gte(2, 1) #=> true
    R.gte(2, 2) #=> true
    R.gte(2, 3) #=> false
    R.gte('a', 'z') #=> false
    R.gte('z', 'a') #=> true

  xit 'has: Returns whether or not an object has an own property with the specified name', ->
    hasName = R.has('name')
    hasName({name: 'alice'})   #=> true
    hasName({name: 'bob'})     #=> true
    hasName({})                #=> false

    point = {x: 0, y: 0}
    pointHas = R.has(R.__, point)
    pointHas('x')  #=> true
    pointHas('y')  #=> true
    pointHas('z')  #=> false

  xit 'hasIn: Returns whether or not an object or its prototype chain has a property with the specified name', ->
    Rectangle = (width, height)->
      this.width = width
      this.height = height
    
    Rectangle.prototype.area = ()-> this.width * this.height

    square = new Rectangle(2, 2)
    R.hasIn('width', square)  #=> true
    R.hasIn('area', square)  #=> true

  xit 'head: Returns the first element of the given list or string. In some libraries this function is named first.', ->
    R.head(['fi', 'fo', 'fum']) #=> 'fi'
    R.head([]) #=> undefined

    R.head('abc') #=> 'a'
    R.head('') #=> ''
  
  xit 'identical: Returns true if its arguments are identical, false otherwise. Values are identical if they reference the same memory. NaN is identical to NaN 0 and -0 are not identical.', ->
    o = {}
    R.identical(o, o) #=> true
    R.identical(1, 1) #=> true
    R.identical(1, '1') #=> false
    R.identical([], []) #=> false
    R.identical(0, -0) #=> false
    R.identical(NaN, NaN) #=> true

  xit 'identity: A function that does nothing but return the parameter supplied to it. Good as a default or placeholder function.', ->
    R.identity(1) #=> 1

    obj = {}
    R.identity(obj) is obj #=> true

  xit 'ifElse: Creates a function that will process either the onTrue or the onFalse function depending upon the result of the condition predicate.', ->
    # Flatten all arrays in the list but leave other values alone.
    flattenArrays = R.map(R.ifElse(Array.isArray, R.flatten, R.identity))

    flattenArrays([[0], [[10], [8]], 1234, {}]) #=> [[0], [10, 8], 1234, {}]
    flattenArrays([[[10], 123], [8, [10]], "hello"]) #=> [[10, 123], [8, 10], "hello"]

  xit 'inc: Increments its argument.', ->
    R.inc(42) #=> 43

  xit 'indexOf: Returns the position of the first occurrence of an item in an array, or -1 if the item is not included in the array. R.equals is used to determine equality.', ->
    R.indexOf(3, [1,2,3,4]) #=> 2
    R.indexOf(10, [1,2,3,4]) #=> -1

  xit 'init: Returns all but the last element of the given list or string.', ->
    R.init([1, 2, 3])  #=> [1, 2]
    R.init([1, 2])     #=> [1]
    R.init([1])        #=> []
    R.init([])         #=> []

    R.init('abc')  #=> 'ab'
    R.init('ab')   #=> 'a'
    R.init('a')    #=> ''
    R.init('')     #=> ''

  xit 'insert: Inserts the supplied element into the list, at index index. Note that this is not destructive: xit returns a copy of the list with the changes. No lists have been harmed in the application of this function.', ->
    R.insert(2, 'x', [1,2,3,4]) #=> [1,2,'x',3,4]

  xit 'insertAll: Inserts the sub-list into the list, at index index. Note that this is not destructive: xit returns a copy of the list with the changes. No lists have been harmed in the application of this function.', ->
    R.insertAll(2, ['x','y','z'], [1,2,3,4]) #=> [1,2,'x','y','z',3,4]

  xit 'intersection: Combines two lists into a set (i.e. no duplicates) composed of those elements common to both lists.', ->
    R.intersection([1,2,3,4], [7,6,5,4,3]) #=> [4, 3]

  xit 'intersectionWith: Combines two lists into a set (i.e. no duplicates) composed of those elements common to both lists. Duplication is determined according to the value returned by applying the supplied predicate to two list elements.', ->
    buffaloSpringfield = [
      {id: 824, name: 'Richie Furay'},
      {id: 956, name: 'Dewey Martin'},
      {id: 313, name: 'Bruce Palmer'},
      {id: 456, name: 'Stephen Stills'},
      {id: 177, name: 'Neil Young'}
    ]
    csny = [
      {id: 204, name: 'David Crosby'},
      {id: 456, name: 'Stephen Stills'},
      {id: 539, name: 'Graham Nash'},
      {id: 177, name: 'Neil Young'}
    ]

    sameId = (o1, o2)-> o1.id is o2.id

    R.intersectionWith(sameId, buffaloSpringfield, csny)
    #=> [{id: 456, name: 'Stephen Stills'}, {id: 177, name: 'Neil Young'}]

  xit 'intersperse: Creates a new list with the separator interposed between elements.', ->
    R.intersperse('n', ['ba', 'a', 'a']) #=> ['ba', 'n', 'a', 'n', 'a']

  xit 'into: Transforms the items of the list with the transducer and appends the transformed items to the accumulator using an appropriate iterator function based on the accumulator type.', ->
    numbers = [1, 2, 3, 4]
    transducer = R.compose(R.map(R.add(1)), R.take(2))

    R.into([], transducer, numbers) #=> [2, 3]

    intoArray = R.into([])
    intoArray(transducer, numbers) #=> [2, 3]

  xit 'invert: Same as R.invertObj, however this accounts for objects with duplicate values by putting the values into an array.', ->
    raceResultsByFirstName = {
      first: 'alice',
      second: 'jake',
      third: 'alice',
    }
    R.invert(raceResultsByFirstName)
    #=> { 'alice': ['first', 'third'], 'jake':['second'] }

  xit 'invertObj: Returns a new object with the keys of the given object as values, and the values of the given object as keys.', ->
    raceResults = {
      first: 'alice',
      second: 'jake'
    }
    R.invertObj(raceResults)
    #=> { 'alice': 'first', 'jake':'second' }

    # Alternatively:
    raceResults = ['alice', 'jake']
    R.invertObj(raceResults)
    #=> { 'alice': '0', 'jake':'1' }

  xit 'invoker: Turns a named method with a specified arity into a function that can be called directly supplied with arguments and a target object.', ->
    sliceFrom = R.invoker(1, 'slice')
    sliceFrom(6, 'abcdefghijklm') #=> 'ghijklm'
    sliceFrom6 = R.invoker(2, 'slice')(6)
    sliceFrom6(8, 'abcdefghijklm') #=> 'gh'

  xit 'is: See if an object (val) is an instance of the supplied constructor. This function will check up the inheritance chain, if any.', ->
    R.is(Object, {}) #=> true
    R.is(Number, 1) #=> true
    R.is(Object, 1) #=> false
    R.is(String, 's') #=> true
    R.is(String, new String('')) #=> true
    R.is(Object, new String('')) #=> true
    R.is(Object, 's') #=> false
    R.is(Number, {}) #=> false

  xit 'isArrayLike: Tests whether or not an object is similar to an array.', ->
    R.isArrayLike([]) #=> true
    R.isArrayLike(true) #=> false
    R.isArrayLike({}) #=> false
    R.isArrayLike({length: 10}) #=> false
    R.isArrayLike({0: 'zero', 9: 'nine', length: 10}) #=> true

  xit 'isEmpty: Reports whether the list has zero elements.', ->
    R.isEmpty([1, 2, 3])   #=> false
    R.isEmpty([])          #=> true
    R.isEmpty('')          #=> true
    R.isEmpty(null)        #=> false
    R.isEmpty(R.keys({}))  #=> true
    R.isEmpty({})          #=> false ({} does not have a length property)
    R.isEmpty({length: 0}) #=> true

  xit 'isNil: Checks if the input value is null or undefined.', ->
    R.isNil(null) #=> true
    R.isNil(undefined) #=> true
    R.isNil(0) #=> false
    R.isNil([]) #=> false

  xit 'isSet: Returns true if all elements are unique, in R.equals terms, otherwise false.', ->
    R.isSet(['1', 1]) #=> true
    R.isSet([1, 1])   #=> false
    R.isSet([[42], [42]]) #=> false

  xit 'join: Returns a string made by inserting the separator between each element and concatenating all the elements into a single string.', ->
    spacer = R.join(' ')
    spacer(['a', 2, 3.4])   #=> 'a 2 3.4'
    R.join('|', [1, 2, 3])    #=> '1|2|3'

  xit 'keys: Returns a list containing the names of all the enumerable own properties of the supplied object. Note that the order of the output array is not guaranteed to be consistent across different JS platforms.', ->
    R.keys({a: 1, b: 2, c: 3}) #=> ['a', 'b', 'c']

  xit 'keysIn: Returns a list containing the names of all the properties of the supplied object, including prototype properties. Note that the order of the output array is not guaranteed to be consistent across different JS platforms.', ->
    F = ()-> this.x = 'X'
    F.prototype.y = 'Y'
    f = new F()
    R.keysIn(f) #=> ['x', 'y']

  xit 'last: Returns the last element of the given list or string.', ->
  R.last(['fi', 'fo', 'fum']) #=> 'fum'
  R.last([]) #=> undefined

  R.last('abc') #=> 'c'
  R.last('') #=> ''

  xit 'lastIndexOf: Returns the position of the last occurrence of an item in an array, or -1 if the item is not included in the array. R.equals is used to determine equality.', ->
    R.lastIndexOf(3, [-1,3,3,0,1,2,3,4]) #=> 6
    R.lastIndexOf(10, [1,2,3,4]) #=> -1

  xit 'length: Returns the number of elements in the array by returning list.length.', ->
    R.length([]) #=> 0
    R.length([1, 2, 3]) #=> 3

  xit 'lens: Returns a lens for the given getter and setter functions. The getter \"gets\" the value of the focus the setter \"sets\" the value of the focus. The setter should not mutate the data structure.', ->
    xLens = R.lens(R.prop('x'), R.assoc('x'))

    R.view(xLens, {x: 1, y: 2})            #=> 1
    R.set(xLens, 4, {x: 1, y: 2})          #=> {x: 4, y: 2}
    R.over(xLens, R.negate, {x: 1, y: 2})  #=> {x: -1, y: 2}

  xit 'lensIndex: Returns a lens whose focus is the specified index.', ->
    headLens = R.lensIndex(0)

    R.view(headLens, ['a', 'b', 'c'])            #=> 'a'
    R.set(headLens, 'x', ['a', 'b', 'c'])        #=> ['x', 'b', 'c']
    R.over(headLens, R.toUpper, ['a', 'b', 'c']) #=> ['A', 'b', 'c']

  xit 'lensProp: Returns a lens whose focus is the specified property.', ->
    xLens = R.lensProp('x')

    R.view(xLens, {x: 1, y: 2})            #=> 1
    R.set(xLens, 4, {x: 1, y: 2})          #=> {x: 4, y: 2}
    R.over(xLens, R.negate, {x: 1, y: 2})  #=> {x: -1, y: 2}

  xit 'lift: "lifts" a function of arity > 1 so that xit may "map over" an Array or other Functor.', ->
    madd3 = R.lift(R.curry((a, b, c)->
      return a + b + c
    ))
    madd3([1,2,3], [1,2,3], [1]) #=> [3, 4, 5, 4, 5, 6, 5, 6, 7]

    madd5 = R.lift(R.curry((a, b, c, d, e)->
      return a + b + c + d + e
    ))
    madd5([1,2], [3], [4, 5], [6], [7, 8]) #=> [21, 22, 22, 23, 22, 23, 23, 24]

  xit 'liftN: "lifts" a function to be the specified arity, so that xit may "map over" that many lists (or other Functors).', ->
    madd3 = R.liftN(3, R.curryN(3, ()->
      return R.reduce(R.add, 0, arguments)
    ))
    madd3([1,2,3], [1,2,3], [1]) #=> [3, 4, 5, 4, 5, 6, 5, 6, 7]

  xit 'lt: Returns true if the first argument is less than the second false otherwise.', ->
    R.lt(2, 1) #=> false
    R.lt(2, 2) #=> false
    R.lt(2, 3) #=> true
    R.lt('a', 'z') #=> true
    R.lt('z', 'a') #=> false

  xit 'lte: Returns true if the first argument is less than or equal to the second false otherwise.', ->
  R.lte(2, 1) #=> false
  R.lte(2, 2) #=> true
  R.lte(2, 3) #=> true
  R.lte('a', 'z') #=> true
  R.lte('z', 'a') #=> false

  xit 'map: Returns a new list, constructed by applying the supplied function to every element of the supplied list.', ->
    double = (x)-> x * 2

    R.map(double, [1, 2, 3]) #=> [2, 4, 6]

  xit 'mapAccum: The mapAccum function behaves like a combination of map and reduce xit applies a function to each element of a list, passing an accumulating parameter from left to right, and returning a final value of this accumulator together with the new list.', ->
    digits = ['1', '2', '3', '4']
    append = (a, b)-> [a + b, a + b]
    R.mapAccum(append, 0, digits) #=> ['01234', ['01', '012', '0123', '01234']]

  xit 'mapAccumRight: The mapAccumRight function behaves like a combination of map and reduce xit applies a function to each element of a list, passing an accumulating parameter from right to left, and returning a final value of this accumulator together with the new list.', ->
    digits = ['1', '2', '3', '4']
    append = (a, b)-> [a + b, a + b]

    R.mapAccumRight(append, 0, digits) #=> ['04321', ['04321', '0432', '043', '04']]

  xit 'mapObj: Map, but for objects. Creates an object with the same keys as obj and values generated by running each property of obj through fn. fn is passed one argument: (value).', ->
    values = { x: 1, y: 2, z: 3 }
    double = (num)-> num * 2

    R.mapObj(double, values) #=> { x: 2, y: 4, z: 6 }

  xit 'mapObjIndexed: Like mapObj, but but passes additional arguments to the predicate function. The predicate function is passed three arguments: (value, key, obj).', ->
    values = { x: 1, y: 2, z: 3 }
    prependKeyAndDouble = (num, key, obj)-> key + (num * 2)
    R.mapObjIndexed(prependKeyAndDouble, values) #=> { x: 'x2', y: 'y4', z: 'z6' }

  xit 'match: Tests a regular expression against a String. Note that this function will return an empty array when there are no matches. This differs from String.prototype.match which returns null when there are no matches.', ->
    R.match(/([a-z]a)/g, 'bananas') #=> ['ba', 'na', 'na']
    R.match(/a/, 'b') #=> []
    R.match(/a/, null) #=> TypeError: null does not have a method named "match"

  xit 'mathMod: mathMod behaves like the modulo operator should mathematically, unlike the % operator (and by extension, R.modulo). So while "-17 % 5" is -2, mathMod(-17, 5) is 3. mathMod requires Integer arguments, and returns NaN when the modulus is zero or negative.', ->
    R.mathMod(-17, 5)  #=> 3
    R.mathMod(17, 5)   #=> 2
    R.mathMod(17, -5)  #=> NaN
    R.mathMod(17, 0)   #=> NaN
    R.mathMod(17.2, 5) #=> NaN
    R.mathMod(17, 5.3) #=> NaN

    clock = R.mathMod(R.__, 12)
    clock(15) #=> 3
    clock(24) #=> 0

    seventeenMod = R.mathMod(17)
    seventeenMod(3)  #=> 2
    seventeenMod(4)  #=> 1
    seventeenMod(10) #=> 7

  xit 'max: Returns the larger of its two arguments.', ->
    R.max(789, 123) #=> 789
    R.max('a', 'b') #=> 'b'

  xit 'maxBy: Takes a function and two values, and returns whichever value produces the larger result when passed to the provided function.', ->
    R.maxBy(((n)-> n * n ), -3, 2) #=> -3

  xit 'mean: Returns the mean of the given list of numbers.', ->
    R.mean([2, 7, 9]) #=> 6
    R.mean([]) #=> NaN

  xit 'median: Returns the median of the given list of numbers.', ->
    R.median([2, 9, 7]) #=> 7
    R.median([7, 2, 10, 9]) #=> 8
    R.median([]) #=> NaN

  xit 'memoize: Creates a new function that, when invoked, caches the result of calling fn for a given argument set and returns the result. Subsequent calls to the memoized fn with the same argument set will not result in an additional call to fn instead, the cached result for that set of arguments will be returned.', ->
    count = 0
    factorial = R.memoize((n)->
      count += 1
      return R.product(R.range(1, n + 1))
    )
    factorial(5) #=> 120
    factorial(5) #=> 120
    factorial(5) #=> 120
    count #=> 1

  xit 'merge: Create a new object with the own properties of a merged with the own properties of object b.', ->
    R.merge({ 'name': 'fred', 'age': 10 }, { 'age': 40 })
    #=> { 'name': 'fred', 'age': 40 }

    resetToDefault = R.merge(R.__, {x: 0})
    resetToDefault({x: 5, y: 2}) #=> {x: 0, y: 2}

  xit 'mergeAll: Merges a list of objects together into one object.', ->
    R.mergeAll([{foo:1},{bar:2},{baz:3}]) #=> {foo:1,bar:2,baz:3}
    R.mergeAll([{foo:1},{foo:2},{bar:2}]) #=> {foo:2,bar:2}

  xit 'min: Returns the smaller of its two arguments.', ->
    R.min(789, 123) #=> 123
    R.min('a', 'b') #=> 'a'

  xit 'minBy: Takes a function and two values, and returns whichever value produces the smaller result when passed to the provided function.', ->
    R.minBy(((n)-> n * n), -3, 2) #=> 2

  xit 'modulo: Divides the second parameter by the first and returns the remainder. Note that this functions preserves the JavaScript-style behavior for modulo. For mathematical modulo see mathMod', ->
    R.modulo(17, 3) #=> 2
    # JS behavior:
    R.modulo(-17, 3) #=> -2
    R.modulo(17, -3) #=> 2

    isOdd = R.modulo(R.__, 2)
    isOdd(42) #=> 0
    isOdd(21) #=> 1

  xit 'multiply: Multiplies two numbers. Equivalent to a * b but curried.', ->
    double = R.multiply(2)
    triple = R.multiply(3)
    double(3)       #=>  6
    triple(4)       #=> 12
    R.multiply(2, 5)  #=> 10

  xit 'nAry: Wraps a function of any arity (including nullary) in a function that accepts exactly n parameters. Any extraneous parameters will not be passed to the supplied function.', ->
    takesTwoArgs = (a, b)-> [a, b]
    takesTwoArgs.length #=> 2
    takesTwoArgs(1, 2) #=> [1, 2]

    takesOneArg = R.nAry(1, takesTwoArgs)
    takesOneArg.length #=> 1
    # Only `n` arguments are passed to the wrapped function
    takesOneArg(1, 2) #=> [1, undefined]

  xit 'negate: Negates its argument.', ->
    R.negate(42) #=> -42

  xit 'none: Returns true if no elements of the list match the predicate, false otherwise.', ->
    R.none(R.isNaN, [1, 2, 3]) #=> true
    R.none(R.isNaN, [1, 2, 3, NaN]) #=> false

  xit 'not: A function that returns the ! of its argument. xit will return true when passed false-y value, and false when passed a truth-y one.', ->
    R.not(true) #=> false
    R.not(false) #=> true
    R.not(0) => true
    R.not(1) => false

  xit 'nth: Returns the nth element of the given list or string. If n is negative the element at index length + n is returned.', ->
    list = ['foo', 'bar', 'baz', 'quux']
    R.nth(1, list) #=> 'bar'
    R.nth(-1, list) #=> 'quux'
    R.nth(-99, list) #=> undefined

    R.nth('abc', 2) #=> 'c'
    R.nth('abc', 3) #=> ''

  xit 'nthArg: Returns a function which returns its nth argument.', ->
    R.nthArg(1)('a', 'b', 'c') #=> 'b'
    R.nthArg(-1)('a', 'b', 'c') #=> 'c'

  xit 'of: Returns a singleton array containing the value provided.', ->
    R.of(null) #=> [null]
    R.of([42]) #=> [[42]]

  xit 'omit: Returns a partial copy of an object omitting the keys specified.', ->
    R.omit(['a', 'd'], {a: 1, b: 2, c: 3, d: 4}) #=> {b: 2, c: 3}

  xit 'once: Accepts a function fn and returns a function that guards invocation of fn such that fn can only ever be called once, no matter how many times the returned function is invoked.', ->
    addOneOnce = R.once((x)-> x + 1 )
    addOneOnce(10) #=> 11
    addOneOnce(addOneOnce(50)) #=> 11

  xit 'or: A function that returns the first truthy of two arguments otherwise the last argument. Note that this is NOT short-circuited, meaning that if expressions are passed they are both evaluated.', ->
    R.or(false, true) #=> true
    R.or(0, []) #=> []
    R.or(null, '') => ''

  xit 'over: Returns the result of "setting" the portion of the given data structure focused by the given lens to the given value.', ->
    headLens = R.lensIndex(0)

    R.over(headLens, R.toUpper, ['foo', 'bar', 'baz']) #=> ['FOO', 'bar', 'baz']

  xit "partial: Accepts as its arguments a function and any number of values and returns a function that, when invoked, calls the original function with all of the values prepended to the original function's arguments list. In some libraries this function is named applyLeft.", ->
    multiply = (a, b)-> a * b
    double = R.partial(multiply, 2)
    double(2) #=> 4

    greet = (salutation, title, firstName, lastName)-> salutation + ', ' + title + ' ' + firstName + ' ' + lastName + '!'
    sayHello = R.partial(greet, 'Hello')
    sayHelloToMs = R.partial(sayHello, 'Ms.')
    sayHelloToMs('Jane', 'Jones') #=> 'Hello, Ms. Jane Jones!'

  xit "partialRight: Accepts as its arguments a function and any number of values and returns a function that, when invoked, calls the original function with all of the values appended to the original function's arguments list.", ->
    greet = (salutation, title, firstName, lastName) -> salutation + ', ' + title + ' ' + firstName + ' ' + lastName + '!'
    greetMsJaneJones = R.partialRight(greet, 'Ms.', 'Jane', 'Jones')

    greetMsJaneJones('Hello') #=> 'Hello, Ms. Jane Jones!'

  xit 'partition: Takes a predicate and a list and returns the pair of lists of elements which do and do not satisfy the predicate, respectively.', ->
    R.partition(R.contains('s'), ['sss', 'ttt', 'foo', 'bars'])
    #=> [ [ 'sss', 'bars' ],  [ 'ttt', 'foo' ] ]

  xit 'path: Retrieve the value at a given path.', ->
    R.path(['a', 'b'], {a: {b: 2}}) #=> 2
    R.path(['a', 'b'], {c: {b: 2}}) #=> undefined

  xit 'pathEq: Determines whether a nested path on an object has a specific value, in R.equals terms. Most likely used to filter a list.', ->
    user1 = { address: { zipCode: 90210 } }
    user2 = { address: { zipCode: 55555 } }
    user3 = { name: 'Bob' }
    users = [ user1, user2, user3 ]
    isFamous = R.pathEq(['address', 'zipCode'], 90210)
    R.filter(isFamous, users) #=> [ user1 ]

  xit 'pick: Returns a partial copy of an object containing only the keys specified. If the key does not exist, the property is ignored.', ->
    R.pick(['a', 'd'], {a: 1, b: 2, c: 3, d: 4}) #=> {a: 1, d: 4}
    R.pick(['a', 'e', 'f'], {a: 1, b: 2, c: 3, d: 4}) #=> {a: 1}

  xit "pickAll: Similar to pick except that this one includes a key: undefined pair for properties that don't exist.", ->
    R.pickAll(['a', 'd'], {a: 1, b: 2, c: 3, d: 4}) #=> {a: 1, d: 4}
    R.pickAll(['a', 'e', 'f'], {a: 1, b: 2, c: 3, d: 4}) #=> {a: 1, e: undefined, f: undefined}

  xit 'pickBy: Returns a partial copy of an object containing only the keys that satisfy the supplied predicate.', ->
    isUpperCase = (val, key)-> key.toUpperCase() is key
    R.pickBy(isUpperCase, {a: 1, b: 2, A: 3, B: 4}) #=> {A: 3, B: 4}

  xit 'pipe: Performs left-to-right function composition. The leftmost function may have any arity the remaining functions must be unary.', ->
    f = R.pipe(Math.pow, R.negate, R.inc)

    f(3, 4) # -(3^4) + 1

  xit 'pipeK: Returns the left-to-right Kleisli composition of the provided functions, each of which must return a value of a type supported by chain.', ->
    #  parseJson :: String -> Maybe *
    #  get :: String -> Object -> Maybe *

    #  getStateCode :: Maybe String -> Maybe String
    getStateCode = R.pipeK(
      parseJson,
      get('user'),
      get('address'),
      get('state'),
      R.compose(Maybe.of, R.toUpper)
    )

    getStateCode(Maybe.of('{"user":{"address":{"state":"ny"}}}'))
    #=> Just('NY')
    getStateCode(Maybe.of('[Invalid JSON]'))
    #=> Nothing()

  xit 'pipeP: Performs left-to-right composition of one or more Promise-returning functions. The leftmost function may have any arity the remaining functions must be unary.', ->
    #  followersForUser :: String -> Promise [User]
    followersForUser = R.pipeP(db.getUserById, db.getFollowers)

  xit 'pluck: Returns a new list by plucking the same named property off all objects in the list supplied.', ->
    R.pluck('a')([{a: 1}, {a: 2}]) #=> [1, 2]
    R.pluck(0)([[1, 2], [3, 4]])   #=> [1, 3]

  xit 'prepend: Returns a new list with the given element at the front, followed by the contents of the list.', ->
    R.prepend('fee', ['fi', 'fo', 'fum']) #=> ['fee', 'fi', 'fo', 'fum']

  xit 'product: Multiplies together all the elements of a list.', ->
    R.product([2,4,6,8,100,1]) #=> 38400

  xit 'project: Reasonable analog to SQL select statement.', ->
    abby = {name: 'Abby', age: 7, hair: 'blond', grade: 2}
    fred = {name: 'Fred', age: 12, hair: 'brown', grade: 7}
    kids = [abby, fred]
    R.project(['name', 'grade'], kids) #=> [{name: 'Abby', grade: 2}, {name: 'Fred', grade: 7}]

  xit 'prop: Returns a function that when supplied an object returns the indicated property of that object, if xit exists.', ->
    R.prop('x', {x: 100}) #=> 100
    R.prop('x', {}) #=> undefined

  xit 'propEq: Returns true if the specified object property is equal, in R.equals terms, to the given value false otherwise.', ->
    abby = {name: 'Abby', age: 7, hair: 'blond'}
    fred = {name: 'Fred', age: 12, hair: 'brown'}
    rusty = {name: 'Rusty', age: 10, hair: 'brown'}
    alois = {name: 'Alois', age: 15, disposition: 'surly'}
    kids = [abby, fred, rusty, alois]
    hasBrownHair = R.propEq('hair', 'brown')
    R.filter(hasBrownHair, kids) #=> [fred, rusty]

  xit 'propIs: Returns true if the specified object property is of the given type false otherwise.', ->
    R.propIs(Number, 'x', {x: 1, y: 2})  #=> true
    R.propIs(Number, 'x', {x: 'foo'})    #=> false
    R.propIs(Number, 'x', {})            #=> false

  xit 'propOr: If the given, non-null object has an own property with the specified name, returns the value of that property. Otherwise returns the provided default value.', ->
    alice = {
      name: 'ALICE',
      age: 101
    }
    favorite = R.prop('favoriteLibrary')
    favoriteWithDefault = R.propOr('Ramda', 'favoriteLibrary')

    favorite(alice)  #=> undefined
    favoriteWithDefault(alice)  #=> 'Ramda'

  xit 'props: Acts as multiple prop: array of keys in, array of values out. Preserves order.', ->
    R.props(['x', 'y'], {x: 1, y: 2}) #=> [1, 2]
    R.props(['c', 'a', 'b'], {b: 2, a: 1}) #=> [undefined, 1, 2]

    fullName = R.compose(R.join(' '), R.props(['first', 'last']))
    fullName({last: 'Bullet-Tooth', age: 33, first: 'Tony'}) #=> 'Tony Bullet-Tooth'

  xit 'propSatisfies: Returns true if the specified object property satisfies the given predicate false otherwise.', ->
    R.propSatisfies(((x)-> x > 0), 'x', {x: 1, y: 2}) #=> true

  xit 'range: Returns a list of numbers from from (inclusive) to to (exclusive).', ->
    R.range(1, 5)    #=> [1, 2, 3, 4]
    R.range(50, 53)  #=> [50, 51, 52]

  xit 'reduce: Returns a single item by iterating through the list, successively calling the iterator function and passing xit an accumulator value and the current value from the array, and then passing the result to the next call.', ->
    numbers = [1, 2, 3]
    add = (a, b)-> a + b

    R.reduce(add, 10, numbers) #=> 16

  xit 'reduced: Returns a value wrapped to indicate that xit is the final value of the reduce and transduce functions. The returned value should be considered a black box: the internal structure is not guaranteed to be stable.', ->
    R.reduce(
      R.pipe(R.add, R.ifElse(R.lte(10), R.reduced, R.identity)),
      0,
      [1, 2, 3, 4, 5]) # 10

  xit 'reduceRight: Returns a single item by iterating through the list, successively calling the iterator function and passing xit an accumulator value and the current value from the array, and then passing the result to the next call.', ->
    pairs = [ ['a', 1], ['b', 2], ['c', 3] ]
    flattenPairs = (acc, pair)-> acc.concat(pair)
    R.reduceRight(flattenPairs, [], pairs) #=> [ 'c', 3, 'b', 2, 'a', 1 ]

  xit 'reject: Similar to filter, except that xit keeps only values for which the given predicate function returns falsy. The predicate function is passed one argument: (value).', ->
    isOdd = (n)-> n % 2 is 1
    R.reject(isOdd, [1, 2, 3, 4]) #=> [2, 4]

  xit 'remove: Removes the sub-list of list starting at index start and containing count elements. Note that this is not destructive: xit returns a copy of the list with the changes. No lists have been harmed in the application of this function.', ->
    R.remove(2, 3, [1,2,3,4,5,6,7,8]) #=> [1,2,6,7,8]

  xit 'repeat: Returns a fixed list of size n containing a specified identical value.', ->
    R.repeat('hi', 5) #=> ['hi', 'hi', 'hi', 'hi', 'hi']

    obj = {}
    repeatedObjs = R.repeat(obj, 5) #=> [{}, {}, {}, {}, {}]
    repeatedObjs[0] is repeatedObjs[1] #=> true

  xit 'replace: Replace a substring or regex match in a string with a replacement.', ->
    R.replace('foo', 'bar', 'foo foo foo') #=> 'bar foo foo'
    R.replace(/foo/, 'bar', 'foo foo foo') #=> 'bar foo foo'

    # Use the "g" (global) flag to replace all occurrences:
    R.replace(/foo/g, 'bar', 'foo foo foo') #=> 'bar bar bar'

  xit 'reverse: Returns a new list with the same elements as the original list, just in the reverse order.', ->
    R.reverse([1, 2, 3])  #=> [3, 2, 1]
    R.reverse([1, 2])     #=> [2, 1]
    R.reverse([1])        #=> [1]
    R.reverse([])         #=> []

  xit 'scan: Scan is similar to reduce, but returns a list of successively reduced values from the left', ->
    numbers = [1, 2, 3, 4]
    factorials = R.scan(R.multiply, 1, numbers) #=> [1, 1, 2, 6, 24]

  xit 'set: Returns the result of "setting" the portion of the given data structure focused by the given lens to the given value.', ->
    xLens = R.lensProp('x')

    R.set(xLens, 4, {x: 1, y: 2})  #=> {x: 4, y: 2}
    R.set(xLens, 8, {x: 1, y: 2})  #=> {x: 8, y: 2}

  xit 'slice: Returns the elements of the given list or string (or object with a slice method) from fromIndex (inclusive) to toIndex (exclusive).', ->
    R.slice(1, 3, ['a', 'b', 'c', 'd'])        #=> ['b', 'c']
    R.slice(1, Infinity, ['a', 'b', 'c', 'd']) #=> ['b', 'c', 'd']
    R.slice(0, -1, ['a', 'b', 'c', 'd'])       #=> ['a', 'b', 'c']
    R.slice(-3, -1, ['a', 'b', 'c', 'd'])      #=> ['b', 'c']
    R.slice(0, 3, 'ramda')                     #=> 'ram'

  xit "sort: Returns a copy of the list, sorted according to the comparator function, which should accept two values at a time and return a negative number if the first value is smaller, a positive number if it's larger, and zero if they are equal. Please note that this is a copy of the list. xit does not modify the original.", ->
    diff = (a, b)-> a - b
    R.sort(diff, [4,2,7,5]) #=> [2, 4, 5, 7]

  xit 'sortBy: Sorts the list according to the supplied function.', ->
    sortByFirstItem = R.sortBy(prop(0))
    sortByNameCaseInsensitive = R.sortBy(R.compose(R.toLower, R.prop('name')))
    pairs = [[-1, 1], [-2, 2], [-3, 3]]
    sortByFirstItem(pairs) #=> [[-3, 3], [-2, 2], [-1, 1]]
    alice = {
      name: 'ALICE',
      age: 101
    }
    bob = {
      name: 'Bob',
      age: -10
    }
    clara = {
      name: 'clara',
      age: 314.159
    }
    people = [clara, bob, alice]
    sortByNameCaseInsensitive(people) #=> [alice, bob, clara]

  xit 'split: Splits a string into an array of strings based on the given separator.', ->
    pathComponents = R.split('/')
    R.tail(pathComponents('/usr/local/bin/node')) #=> ['usr', 'local', 'bin', 'node']

    R.split('.', 'a.b.c.xyz.d') #=> ['a', 'b', 'c', 'xyz', 'd']

  xit 'splitEvery: Splits a collection into slices of the specified length.', ->
    R.splitEvery(3, [1, 2, 3, 4, 5, 6, 7]) #=> [[1, 2, 3], [4, 5, 6], [7]]
    R.splitEvery(3, 'foobarbaz') #=> ['foo', 'bar', 'baz']

  xit 'subtract: Subtracts two numbers. Equivalent to a - b but curried.', ->
    R.subtract(10, 8) #=> 2

    minus5 = R.subtract(R.__, 5)
    minus5(17) #=> 12

    complementaryAngle = R.subtract(90)
    complementaryAngle(30) #=> 60
    complementaryAngle(72) #=> 18

  xit 'sum: Adds together all the elements of a list.', ->
    R.sum([2,4,6,8,100,1]) #=> 121

  xit 'T: A function that always returns true. Any passed in parameters are ignored.', ->
    R.T() #=> true

  xit 'tail: Returns all but the first element of the given list or string (or object with a tail method).', ->
    R.tail([1, 2, 3])  #=> [2, 3]
    R.tail([1, 2])     #=> [2]
    R.tail([1])        #=> []
    R.tail([])         #=> []

    R.tail('abc')  #=> 'bc'
    R.tail('ab')   #=> 'b'
    R.tail('a')    #=> ''
    R.tail('')     #=> ''

  xit 'take: Returns the first n elements of the given list, string, or transducer/transformer (or object with a take method).', ->
    R.take(1, ['foo', 'bar', 'baz']) #=> ['foo']
    R.take(2, ['foo', 'bar', 'baz']) #=> ['foo', 'bar']
    R.take(3, ['foo', 'bar', 'baz']) #=> ['foo', 'bar', 'baz']
    R.take(4, ['foo', 'bar', 'baz']) #=> ['foo', 'bar', 'baz']
    R.take(3, 'ramda')               #=> 'ram'

    personnel = [
      'Dave Brubeck',
      'Paul Desmond',
      'Eugene Wright',
      'Joe Morello',
      'Gerry Mulligan',
      'Bob Bates',
      'Joe Dodge',
      'Ron Crotty'
    ]

    takeFive = R.take(5)
    takeFive(personnel)
    #=> ['Dave Brubeck', 'Paul Desmond', 'Eugene Wright', 'Joe Morello', 'Gerry Mulligan']

  xit 'takeLast: Returns a new list containing the last n elements of the given list. If n > list.length, returns a list of list.length elements.', ->
    R.takeLast(1, ['foo', 'bar', 'baz']) #=> ['baz']
    R.takeLast(2, ['foo', 'bar', 'baz']) #=> ['for', 'baz']
    R.takeLast(3, ['foo', 'bar', 'baz']) #=> ['foo', 'bar', 'baz']
    R.takeLast(4, ['foo', 'bar', 'baz']) #=> ['foo', 'bar', 'baz']
    R.takeLast(3, 'ramda')               #=> 'mda'

  xit 'takeLastWhile: Returns a new list containing the last n elements of a given list, passing each value to the supplied predicate function, and terminating when the predicate function returns false. Excludes the element that caused the predicate function to fail. The predicate function is passed one argument: (value).', ->
    isNotOne = (x)-> !(x is 1)

    R.takeLastWhile(isNotOne, [1, 2, 3, 4]) #=> [2, 3, 4]

  xit 'takeWhile: Returns a new list containing the first n elements of a given list, passing each value to the supplied predicate function, and terminating when the predicate function returns false. Excludes the element that caused the predicate function to fail. The predicate function is passed one argument: (value).', ->
    isNotFour = (x)-> !(x is 4)

    R.takeWhile(isNotFour, [1, 2, 3, 4]) #=> [1, 2, 3]

  xit 'tap: Runs the given function with the supplied object, then returns the object.', ->
    sayX = (x)-> console.log('x is ' + x)
    R.tap(sayX, 100) #=> 100
    #-> 'x is 100'

  xit 'test: Determines whether a given string matches a given regular expression.', ->
    R.test(/^x/, 'xyz') #=> true
    R.test(/^y/, 'xyz') #=> false

  xit 'times: Calls an input function n times, returning an array containing the results of those function calls.', ->
    R.times(R.identity, 5) #=> [0, 1, 2, 3, 4]

  xit 'toLower: The lower case version of a string.', ->
    R.toLower('XYZ') #=> 'xyz'

  xit "toPairs: Converts an object into an array of key, value arrays. Only the object's own properties are used. Note that the order of the output array is not guaranteed to be consistent across different JS platforms.", ->
    R.toPairs({a: 1, b: 2, c: 3}) #=> [['a', 1], ['b', 2], ['c', 3]]

  xit "toPairsIn: Converts an object into an array of key, value arrays. The object's own properties and prototype properties are used. Note that the order of the output array is not guaranteed to be consistent across different JS platforms.", ->
    F = ()-> this.x = 'X'
    F.prototype.y = 'Y'
    f = new F()
    R.toPairsIn(f) #=> [['x','X'], ['y','Y']]

  xit "toString: Returns the string representation of the given value. eval'ing the output should result in a value equivalent to the input value. Many of the built-in toString methods do not satisfy this requirement.", ->
    Point = (x, y)->
      this.x = x
      this.y = y

    Point.prototype.toString = ()-> 'new Point(' + this.x + ', ' + this.y + ')'

    R.toString(new Point(1, 2)) #=> 'new Point(1, 2)'
    R.toString(42) #=> '42'
    R.toString('abc') #=> '"abc"'
    R.toString([1, 2, 3]) #=> '[1, 2, 3]'
    R.toString({foo: 1, bar: 2, baz: 3}) #=> '{"bar": 2, "baz": 3, "foo": 1}'
    R.toString(new Date('2001-02-03T04:05:06Z')) #=> 'new Date("2001-02-03T04:05:06.000Z")'

  xit 'toUpper: The upper case version of a string.', ->
    R.toUpper('abc') #=> 'ABC'

  xit 'transduce: Initializes a transducer using supplied iterator function. Returns a single item by iterating through the list, successively calling the transformed iterator function and passing xit an accumulator value and the current value from the array, and then passing the result to the next call.', ->
    numbers = [1, 2, 3, 4]
    transducer = R.compose(R.map(R.add(1)), R.take(2))

    R.transduce(transducer, R.flip(R.append), [], numbers) #=> [2, 3]

  xit 'trim: Removes (strips) whitespace from both ends of the string.', ->
    R.trim('   xyz  ') #=> 'xyz'
    R.map(R.trim, R.split(',', 'x, y, z')) #=> ['x', 'y', 'z']

  xit "type: Gives a single-word string description of the (native) type of a value, returning such answers as 'Object', 'Number', 'Array', or 'Null'. Does not attempt to distinguish user Object types any further, reporting them all as 'Object'.", ->
    R.type({}) #=> "Object"
    R.type(1) #=> "Number"
    R.type(false) #=> "Boolean"
    R.type('s') #=> "String"
    R.type(null) #=> "Null"
    R.type([]) #=> "Array"
    R.type(/[A-z]/) #=> "RegExp"

  xit 'unapply: Takes a function fn, which takes a single array argument, and returns a function which [...]', ->
    R.unapply(JSON.stringify)(1, 2, 3) #=> '[1,2,3]'

  xit 'unary: Wraps a function of any arity (including nullary) in a function that accepts exactly 1 parameter. Any extraneous parameters will not be passed to the supplied function.', ->
    takesTwoArgs = (a, b)-> [a, b]
    takesTwoArgs.length #=> 2
    takesTwoArgs(1, 2) #=> [1, 2]

    takesOneArg = R.unary(takesTwoArgs)
    takesOneArg.length #=> 1
    # Only 1 argument is passed to the wrapped function
    takesOneArg(1, 2) #=> [1, undefined]

  xit 'uncurryN: Returns a function of arity n from a (manually) curried function.', ->
    addFour = (a)-> (b)-> (c)-> (d)-> a + b + c + d

    uncurriedAddFour = R.uncurryN(4, addFour)
    curriedAddFour(1, 2, 3, 4) #=> 10

  xit 'unfold: Builds a list from a seed value. Accepts an iterator function, which returns either false to stop iteration or an array of length 2 containing the value to add to the resulting list and the seed to be used in the next call to the iterator function.', ->
    f = (n)-> n > 50 ? false : [-n, n + 10]
    R.unfold(f, 10) #=> [-10, -20, -30, -40, -50]

  xit 'union: Combines two lists into a set (i.e. no duplicates) composed of the elements of each list.', ->
    R.union([1, 2, 3], [2, 3, 4]) #=> [1, 2, 3, 4]

  xit 'unionWith: Combines two lists into a set (i.e. no duplicates) composed of the elements of each list. Duplication is determined according to the value returned by applying the supplied predicate to two list elements.', ->
    cmp = (x, y)-> x.a is y.a
    l1 = [{a: 1}, {a: 2}]
    l2 = [{a: 1}, {a: 4}]
    R.unionWith(cmp, l1, l2) #=> [{a: 1}, {a: 2}, {a: 4}]

  xit 'uniq: Returns a new list containing only one copy of each element in the original list. R.equals is used to determine equality.', ->
    R.uniq([1, 1, 2, 1]) #=> [1, 2]
    R.uniq([1, '1'])     #=> [1, '1']
    R.uniq([[42], [42]]) #=> [[42]]

  xit 'uniqBy: Returns a new list containing only one copy of each element in the original list, based upon the value returned by applying the supplied function to each list element. Prefers the first item if the supplied function produces the same value on two items. R.equals is used for comparison.', ->
    R.uniqBy(Math.abs, [-1, -5, 2, 10, 1, 2]) #=> [-1, -5, 2, 10]

  xit 'uniqWith: Returns a new list containing only one copy of each element in the original list, based upon the value returned by applying the supplied predicate to two list elements. Prefers the first item if two items compare equal based on the predicate.', ->
    strEq = (a, b)-> String(a) is String(b)
    R.uniqWith(strEq)([1, '1', 2, 1]) #=> [1, 2]
    R.uniqWith(strEq)([{}, {}])       #=> [{}]
    R.uniqWith(strEq)([1, '1', 1])    #=> [1]
    R.uniqWith(strEq)(['1', 1, 1])    #=> ['1']

  xit 'unnest: Returns a new list by pulling every item at the first level of nesting out, and putting them in a new array.', ->
    R.unnest([1, [2], [[3]]]) #=> [1, 2, [3]]
    R.unnest([[1, 2], [3, 4], [5, 6]]) #=> [1, 2, 3, 4, 5, 6]

  xit 'update: Returns a new copy of the array with the element at the provided index replaced with the given value.', ->
    R.update(1, 11, [0, 1, 2])     #=> [0, 11, 2]
    R.update(1)(11)([0, 1, 2])     #=> [0, 11, 2]

  xit 'useWith: Accepts a function fn and any number of transformer functions and returns a new function. When the new function is invoked, xit calls the function fn with parameters consisting of the result of calling each supplied handler on successive arguments to the new function.', ->
    double = (y)-> y * 2
    square = (x)-> x * x
    add = (a, b)-> a + b
    # Adds any number of arguments together
    addAll = ()-> R.reduce(add, 0, arguments)

    # Basic example
    addDoubleAndSquare = R.useWith(addAll, double, square)

    #≅ addAll(double(10), square(5))
    addDoubleAndSquare(10, 5) #=> 45

    # Example of passing more arguments than transformers
    #≅ addAll(double(10), square(5), 100)
    addDoubleAndSquare(10, 5, 100) #=> 145

    # If there are extra _expected_ arguments that don't need to be transformed, although
    # you can ignore them, xit might be best to pass in the identity function so that the new
    # function correctly reports arity.
    addDoubleAndSquareWithExtraParams = R.useWith(addAll, double, square, R.identity)
    # addDoubleAndSquareWithExtraParams.length #=> 3
    #≅ addAll(double(10), square(5), R.identity(100))
    addDoubleAndSquare(10, 5, 100) #=> 145

  xit 'values: Returns a list of all the enumerable own properties of the supplied object. Note that the order of the output array is not guaranteed across different JS platforms.', ->
    R.values({a: 1, b: 2, c: 3}) #=> [1, 2, 3]
  
  xit 'valuesIn: Returns a list of all the properties, including prototype properties, of the supplied object. Note that the order of the output array is not guaranteed to be consistent across different JS platforms.', ->
    F = ()-> this.x = 'X'
    F.prototype.y = 'Y'
    f = new F()
    R.valuesIn(f) #=> ['X', 'Y']

  xit 'view: Returns a "view" of the given data structure, determined by the given lens. The lens\'s focus determines which portion of the data structure is visible.', ->
    xLens = R.lensProp('x')
    R.view(xLens, {x: 1, y: 2})  #=> 1
    R.view(xLens, {x: 4, y: 2})  #=> 4

  xit "where: Takes a spec object and a test object returns true if the test satisfies the spec. Each of the spec's own properties must be a predicate function. Each predicate is applied to the value of the corresponding property of the test object. where returns true if all the predicates return true, false otherwise.", ->
    # pred :: Object -> Boolean
    pred = R.where({
      a: R.equals('foo'),
      b: R.complement(R.equals('bar')),
      x: R.gt(_, 10),
      y: R.lt(_, 20)
    })

    pred({a: 'foo', b: 'xxx', x: 11, y: 19}) #=> true
    pred({a: 'xxx', b: 'xxx', x: 11, y: 19}) #=> false
    pred({a: 'foo', b: 'bar', x: 11, y: 19}) #=> false
    pred({a: 'foo', b: 'xxx', x: 10, y: 19}) #=> false
    pred({a: 'foo', b: 'xxx', x: 11, y: 20}) #=> false

  xit "whereEq: Takes a spec object and a test object returns true if the test satisfies the spec, false otherwise. An object satisfies the spec if, for each of the spec's own properties, accessing that property of the object gives the same value (in R.equals terms) as accessing that property of the spec.", ->
    # pred :: Object -> Boolean
    pred = R.whereEq({a: 1, b: 2})

    pred({a: 1})              #=> false
    pred({a: 1, b: 2})        #=> true
    pred({a: 1, b: 2, c: 3})  #=> true
    pred({a: 1, b: 1})        #=> false

  xit 'wrap: Wrap a function inside another to allow you to make adjustments to the parameters, or do other processing either before the internal function is called or with its results.', ->
    greet = (name)-> 'Hello ' + name

    shoutedGreet = R.wrap(greet, (gr, name)-> gr(name).toUpperCase())
    shoutedGreet('Kathy') #=> "HELLO KATHY"

    shortenedGreet = R.wrap(greet, (gr, name)-> gr(name.substring(0, 3)))
    shortenedGreet('Robert') #=> "Hello Rob"

  xit 'xprod: Creates a new list out of the two supplied by creating each possible pair from the lists.', ->
    R.xprod([1, 2], ['a', 'b']) #=> [[1, 'a'], [1, 'b'], [2, 'a'], [2, 'b']]

  xit 'zip: Creates a new list out of the two supplied by pairing up equally-positioned items from both lists. The returned list is truncated to the length of the shorter of the two input lists. Note: zip is equivalent to zipWith(function(a, b) { return [a, b] }).', ->
    R.zip([1, 2, 3], ['a', 'b', 'c']) #=> [[1, 'a'], [2, 'b'], [3, 'c']]

  xit 'zipObj: Creates a new object out of a list of keys and a list of values.', ->
    R.zipObj(['a', 'b', 'c'], [1, 2, 3]) #=> {a: 1, b: 2, c: 3}
  
  xit 'zipWith: Creates a new list out of the two supplied by applying the function to each equally-positioned pair in the lists. The returned list is truncated to the length of the shorter of the two input lists.', ->
    f = NOOP
    R.zipWith(f, [1, 2, 3], ['a', 'b', 'c'])
    #=> [f(1, 'a'), f(2, 'b'), f(3, 'c')]