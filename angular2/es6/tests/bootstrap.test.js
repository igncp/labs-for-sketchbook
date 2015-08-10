import {AsyncTestCompleter, inject, describe, it, xit} from 'angular2/test_lib';
import {PromiseWrapper} from 'angular2/src/facade/async';

import {bootstrap} from 'angular2/angular2';

class Foo {}

describe('bootstrap', function() {
  it('exists', inject([AsyncTestCompleter], (async) => {
    expect(bootstrap).toBeTruthy();
    async.done();
  }));
  xit('creates an application', inject([AsyncTestCompleter], (async) => {
    // There might be a bug as DOM can not be imported
    var refPromise = bootstrap(Foo, []);

    PromiseWrapper.then(refPromise, null, (reason) => {
      console.log("reason.message", reason.message);
      expect(reason.message).toContain('Foo');
      async.done();
      return null;
    });
  }));
});
