chai = require 'chai'
expect = chai.expect
jsdom = require 'mocha-jsdom'

React = require '../../react/npm-react/dist/react'
ReactTestUtils = require '../../react/modules/ReactTestUtils'


describe 'ReactDOM', ()->
  jsdom()

  it 'allows a DOM element to be used with a string', ()->
    element = React.createElement('a', { className: 'bar' })
    instance = ReactTestUtils.renderIntoDocument(element)

    expect(instance.getDOMNode().tagName).to.equal('A')

  it 'should allow children to be passed as an argument', ()->
    p = React.createFactory('p')
    instance = ReactTestUtils.renderIntoDocument( p(null, 'foo') )
    argNode = instance.getDOMNode()

    expect(argNode.innerHTML).to.equal 'foo'

  it 'should overwrite props.children with children argument', ()->
    p = React.createFactory 'p'
    conflictP = ReactTestUtils.renderIntoDocument( p({ children: 'fakechild' }, 'child') )
    conflictNode = conflictP.getDOMNode()
    
    expect(conflictNode.innerHTML).to.equal 'child'
