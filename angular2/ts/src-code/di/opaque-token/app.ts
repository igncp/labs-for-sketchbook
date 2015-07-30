import {OpaqueToken} from 'angular2/di';

var opaqueOne = new OpaqueToken('one');

console.log("opaqueOne", opaqueOne);
console.log("opaqueOne.toString()", opaqueOne.toString());