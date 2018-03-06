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
    
    this.userService.register({email, password} as User)
      .subscribe(_ => "Kris");
  }

}
