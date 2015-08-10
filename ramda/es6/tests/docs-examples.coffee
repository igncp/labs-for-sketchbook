describe 'docs examples', ->
  describe 'add', ->
    it 'sums numbers', ->
      expect(R.add(2, 3)).to.equal(5)
      expect(R.add(7)(10)).to.equal(17)