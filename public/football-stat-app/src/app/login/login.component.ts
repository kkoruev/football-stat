import { Component, OnInit, Input } from '@angular/core';
import { LoginService } from '../login.service'

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})

export class LoginComponent implements OnInit {


  @Input() email: string;
  @Input() password: string;

  constructor(private loginService: LoginService) { }

  ngOnInit() {
  }


  login(email: string, password: string): void{
    this.loginService.login(email, password);
  }

}
