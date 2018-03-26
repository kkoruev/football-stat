import { Component, OnInit } from '@angular/core';

import { User } from '../user'

import { UserService } from '../user.service'

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit {
  constructor(
    private userService: UserService
  ) { }

  ngOnInit() {
  }

  register(email: string, nickname: string, password: string): void {
    var data1;
    var error1;

    this.userService.register({email, nickname,  password} as User)
      .subscribe(
        data => data1 = data,
        error => error1 = error
      );
        
    console.log(data1)
    console.log(error1)
  }

}
