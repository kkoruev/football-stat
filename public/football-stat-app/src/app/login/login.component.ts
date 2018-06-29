import { Component, OnInit, Input } from '@angular/core';
import { UserService } from '../user.service'

import { Router } from '@angular/router';
import { SharedTokenService } from "../shared/shared-token.service";

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})

export class LoginComponent implements OnInit {

  error: string;

  constructor(
    private userService: UserService,
    private router: Router,
    private sharedTokenService: SharedTokenService
  ) { }

  ngOnInit() {
  }

  login(email: string, password: string): void{
    this.userService.login(email, password)
      .subscribe(response => {
        this.sharedTokenService.setToken(response.headers.get('X-Auth-Token'));
        var user = response.body
        this.error = "";
        if (user === 'U') {
          this.router.navigate(['/predictions']);
        } else {
          this.router.navigate(['admin/add-teams']);
        }

      }, error => {
        if (error.status === 200) {
          this.sharedTokenService.setToken(error.headers.get('X-Auth-Token'));
          var user = error.error.text
          this.error = "";
          if(user === 'U') {
            this.router.navigate(['/predictions']);
          } else {
            this.router.navigate(['admin/add-teams']);
          }

        } else {
          this.error = "Problem with your login input. Try again! " +
                  "If you are sure that your input is correct " +
                  "Please contract the administrator."
        }
      });
  }

}
