import {AsyncTestCompleter, inject, describe, it, xit} from 'angular2/test_lib';
import {PromiseWrapper} from 'angular2/src/facade/async';
import {DOM} from 'angular2/src/dom/dom_adapter';

import {bootstrap} from 'angular2/angular2';

class Foo {}

describe('bootstrap', function() {
  it('exists', inject([AsyncTestCompleter], (async) => {
    expect(bootstrap).toBeTruthy();
    async.done();
  }));
  xit('creates an application', inject([AsyncTestCompleter], (async) => {
    var refPromise = bootstrap(Foo, []);

    PromiseWrapper.then(refPromise, null, (reason) => {
      console.log("reason.message", reason.message);
      expect(reason.message).toContain('Foo');
      async.done();
      return null;
    });
  }));
});
