chai = require('chai');
expect = chai.expect;
jsdom = require('mocha-jsdom');

React = require('../../react/npm-react/dist/react');
ReactTestUtils = require('../../react/modules/ReactTestUtils');

describe('ReactDOM', ()->
  jsdom()

  it("allows a DOM element to be used with a string", ()->
    expect(1).to.equal 2
  )

)
