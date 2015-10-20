module.exports = function(file, api) {
  const j = api.jscodeshift;

  return j(file.source)
    .find(j.Identifier)
    .replaceWith(()=> 'bar')
    .toSource();
};
