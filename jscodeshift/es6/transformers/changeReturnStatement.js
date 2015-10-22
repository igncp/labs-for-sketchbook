module.exports = function(file, api) {
  const j = api.jscodeshift;

  return j(file.source)
    .find(j.ReturnStatement)
    .forEach((p)=> {
        j(p.value)
          .find(j.Identifier)
          .replaceWith(()=> '"replaced return statement"');
    }).toSource();
};
