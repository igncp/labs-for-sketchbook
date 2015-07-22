import {Component, bootstrap, View, NgIf} from "angular2/angular2";  
import {formDirectives} from "angular2/forms";
 
@Component({  
  selector: 'app'
})  
@View({  
  directives: [formDirectives, NgIf],  
  templateUrl: 'app.html'
})  
class FormExample {
  text: string = '';
  submitText: string = '';
  fillText(form, values) {
    this.text = values.name || '';
  }
  onSubmit(values) {  
    this.submitText = 'You entered the values: ' + JSON.stringify(values);
  }
}

bootstrap(FormExample);