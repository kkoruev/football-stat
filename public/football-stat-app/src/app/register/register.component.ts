import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

import { User } from '../types/user';

import { UserService } from '../user.service';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit {

  data: any;

  constructor(
    private router: Router,
    private userService: UserService
  ) { }

  ngOnInit() {
  }

register(email: string, nickname: string, password: string): void {
  this.data = '';
  this.userService.register({email, nickname,  password} as User)
    .subscribe(
      data => {
        this.data = 'success';
        console.log(this.data);
      },
      error => {
        console.log(error);
        this.data = error.error;
        if (error.status === 200) {
          this.router.navigate(['/login']);
        }
      }
    );
  }
}
