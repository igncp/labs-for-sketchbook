import {
    ComponentAnnotation as Component,
    ViewAnnotation as View,
    bootstrap,
    routerInjectables,
} from 'angular2/angular2';

@Component({
  selector: 'app'
})
@View({
  templateUrl: `app.html`,
})
class App {}

bootstrap(App);