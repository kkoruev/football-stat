import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'app';
  isLogged: boolean;
  isAdmin: boolean;

  constructor() {
    this.isAdmin = false;
    this.isLogged = false;
  }
}
