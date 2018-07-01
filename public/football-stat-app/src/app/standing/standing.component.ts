import { Component, OnInit } from '@angular/core';
import { Router } from "@angular/router";
import { UserPoints } from "../types/user_points";
import { UserService } from "../user.service";
import { SharedTokenService } from "../shared/shared-token.service";

@Component({
  selector: 'app-standing',
  templateUrl: './standing.component.html',
  styleUrls: ['./standing.component.css']
})
export class StandingComponent implements OnInit {

  users: UserPoints[];

  constructor(private router: Router,
              private userService: UserService,
              private sharedService: SharedTokenService) { }

  ngOnInit() {
    this.loadStaning();
  }


  loadStaning() {
    this.userService.usersStanding(this.sharedService.getToken()).subscribe(
      response => {
        this.users = response.body;
        this.sharedService.setToken(response.headers.get('X-Auth-Token'))
      }, error => {
        if(error.status === 401) {
          this.router.navigate(['/expired']);
        }
      }
    )
  }

  predictMatches() {
    this.router.navigate(['predictions']);
  }

  standing(){
    this.router.navigate(['/standing']);
  }

  statistics(){
    this.router.navigate(['/statistics']);
  }

  logout() {
    this.router.navigate(['/login']);
  }
}
