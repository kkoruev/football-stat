import { Component, OnInit, Input } from '@angular/core';
import { UserService } from '../user.service'

import { Router } from '@angular/router';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})

export class LoginComponent implements OnInit {

  constructor(
    private userService: UserService,
    private router: Router
  ) { }

  // constructor () {}

  ngOnInit() {
  }


  login(email: string, password: string): void{
    this.userService.login(email, password)
      .subscribe(_ => this.router.navigate['register']);
    this.router.navigate['register'];
  }

}
