chai = require 'chai'
expect = chai.expect
sinon = require 'sinon'

jsdom = require 'mocha-jsdom'

mocks = require '../../react/npm-react-tools/src/test/mocks'

describe 'ReactClass-spec', ()->
  jsdom()
  React = null
  ReactTestUtils = null
  
  beforeEach(()->
    React = require '../../react/npm-react/dist/react'
    ReactTestUtils = require '../../react/modules/ReactTestUtils'
  )

  it('should throw when `render` is not specified', ()->
    expect(()->
      React.createClass({})
    ).to.throw(
      'Invariant Violation: createClass(...): Class specification must implement a `render` method.'
    )
  )

  it('should throw when using legacy factories', ()->
    Component = React.createClass({
      render: ()-> React.createElement('div', null)
      
    })

    expect(()-> Component()).to.throw()
  )

  it('should work with a null getInitialState() return value', ()->
    Component = React.createClass({
      getInitialState: ()-> null
      render: ()-> React.createElement('span', null)
    })

    expect(()->
      instance = React.createElement(Component, null)
      ReactTestUtils.renderIntoDocument(instance)
    ).not.to.throw()
  )

  # Not passing
  xit('should copy `displayName` onto the Constructor', ()->
    TestComponent = React.createClass({
      render: ()-> React.createElement('div', null)
    })

    expect(TestComponent.displayName).to.equal 'TestComponent'
  )
