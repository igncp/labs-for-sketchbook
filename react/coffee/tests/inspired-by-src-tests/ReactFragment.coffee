chai = require 'chai'
expect = chai.expect
sinon = require 'sinon'
jsdom = require 'mocha-jsdom'

ReactTestUtils = require '../../react/modules/ReactTestUtils'
React = require '../../react/npm-react/dist/react'
ReactFragment = require '../../react/modules/ReactFragment'

describe 'ReactFragment', ()->
  nativeWarn = null
  beforeEach ->
    jsdom()
    nativeWarn = console.warn
    console.warn = ()-> null

  afterEach ->
    console.warn.restore()
    console.warn = nativeWarn

  # This test only warns the first time mocha is run.
  # This is maybe because 'Only warn once for the same set of children'
  # and there is some pooling going around
  it 'should warn if a plain object is used as a child', ->
    sinon.spy(console, 'warn')
    children =
      x: React.createElement('span', null)
      y: React.createElement('span', null)
    
    React.createElement('div', null, children)
    warns = console.warn.callCount

    if warns is 1
      expect(console.warn.getCall(0).args[0]).to.contain('Any use of a keyed object')
    
    sameChildren =
      x: React.createElement('span', null)
      y: React.createElement('span', null)
    React.createElement('div', null, sameChildren)
    
    expect(console.warn.callCount).to.equal warns
