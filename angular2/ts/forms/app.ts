import {Component, bootstrap, View} from "angular2/angular2";  
import {formDirectives} from "angular2/forms";
 
@Component({  
  selector: 'app'  
})  
@View({  
  directives: [formDirectives],  
  templateUrl: 'app.html'
})  
class FormExample {
  fillText(form, values) {
    console.log(values);
  }
  onSubmit(values) {  
    console.log('You entered the values: ', values);  
  }
}

bootstrap(FormExample);