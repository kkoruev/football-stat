import { Component, OnInit } from '@angular/core';

import { AddTeamsService } from './add-teams.service';

import { Team } from '../../types/team';

@Component({
  selector: 'app-add-teams',
  templateUrl: './add-teams.component.html',
  styleUrls: ['./add-teams.component.css']
})
export class AddTeamsComponent implements OnInit {

  teams: Team[];
  newTeam = '';
  data = '';
  constructor(private addTeamsService: AddTeamsService) { }

  ngOnInit() {
    this.getData();
  }

  getData() {
    this.addTeamsService.getTeams().subscribe(
      response => {
        this.teams = response;
        console.log(this.teams);
      }
    );
  }

  saveTeam(teamName: string) {
    this.data = ''
    this.addTeamsService.createTeam(teamName).subscribe(response => {
      this.newTeam = '';
      this.getData();
    }, error => {
      if (error.status === 200) {
        this.newTeam = '';
        this.getData();
      } else {
        this.data = error.error
      }
    });
  }

  removeTeam(teamName: string) {
    this.addTeamsService.removeTeam(teamName).subscribe(
      response => {
        this.getData();
      }, error => {
        if(error.status === 200) {
          this.getData();
        } else {
          this.data = error.error
        }
      });
  }
}
