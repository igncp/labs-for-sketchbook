import {
  Injectable,
  Component,
  View,
  bootstrap,
  bind
} from "angular2/angular2";

@Injectable()
class PlanetFactoryService {
  constructor(){}
  getPlanet(): string {
    return "world!";
  }
}

@Component({
  selector: "app",
  viewInjector: [PlanetFactoryService]
})
@View({
  templateUrl: "app.html"
})
class HelloWorldApp {
  planet: string;
  changePlanet() {
    this.planet = 'foo'; // I don't know how to update this
    console.log('clicked');
  }
  constructor(planetFactory: PlanetFactoryService) {
    console.log(planetFactory);
    this.planet = planetFactory.getPlanet();
  }
}

bootstrap(HelloWorldApp);
