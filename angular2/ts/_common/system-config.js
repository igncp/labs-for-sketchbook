System.config({
  transpiler: "typescript",
  typescriptOptions: {
    emitDecoratorMetadata: true,
    experimentalDecorators: true
  },
  "traceurOptions": {
    "annotations": true,
    "memberVariables": true,
    "types": true
  },
});
System.paths = {
  "app": "app.ts"
};
System.import('app');
