import {Injector, Injectable} from 'angular2/di';

class Engine {
  constructor() {
    console.log('engine instatiated');
  }
}

class Car{
  name: string = 'mustang';
  constructor(@Injectable() engine: Engine) {
    console.log('car instantiated');
  }
}

var injector = Injector.resolveAndCreate([Car, Engine]);

console.log("injector", injector);
console.log("injector.get(Car)", injector.get(Car));