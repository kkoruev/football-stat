import { Component, OnInit } from '@angular/core';

import { AddTeamsService } from './add-teams.service';

import { Team } from '../../types/team';
import { SharedTokenService } from "../../shared/shared-token.service";
import { Router } from '@angular/router'

@Component({
  selector: 'app-add-teams',
  templateUrl: './add-teams.component.html',
  styleUrls: ['./add-teams.component.css']
})
export class AddTeamsComponent implements OnInit {

  teams: Team[];
  newTeam = '';
  data = '';
  constructor(private addTeamsService: AddTeamsService,
              private router: Router,
              private sharedTokenService: SharedTokenService) { }

  ngOnInit() {
    this.getData();
  }

  getData() {
    this.addTeamsService.getTeams(this.sharedTokenService.getToken()).subscribe(
      response => {
        this.teams = response.body;
        this.sharedTokenService.setToken(response.headers.get('X-Auth-Token'))
        console.log(this.teams);
      }, error => {
        if(error.status === 401) {
          this.router.navigate(['/expired']);
        }
      }
    );
  }

  saveTeam(teamName: string) {
    this.data = ''
    this.addTeamsService.createTeam(teamName, this.sharedTokenService.getToken())
    .subscribe(response => {
      this.sharedTokenService.setToken(response.headers.get('X-Auth-Token'))
      this.newTeam = '';
      this.getData();
    }, error => {
      if (error.status === 200) {
        this.sharedTokenService.setToken(error.headers.get('X-Auth-Token'))
        this.newTeam = '';
        this.getData();
      } else if(error.status === 401){
        this.router.navigate(['/expired']);
      } else {
        this.data = error.error
      }
    });
  }

  removeTeam(teamName: string) {
    this.addTeamsService.removeTeam(teamName, this.sharedTokenService.getToken())
    .subscribe(
      response => {
        this.sharedTokenService.setToken(response.headers.get('X-Auth-Token'))
        this.getData();
      }, error => {
        if(error.status === 200) {
          this.sharedTokenService.setToken(error.headers.get('X-Auth-Token'))
          this.getData();
        } else if(error.status === 401){
          this.router.navigate(['/expired']);
        } else {
          this.data = error.error
        }
      });
  }
}
