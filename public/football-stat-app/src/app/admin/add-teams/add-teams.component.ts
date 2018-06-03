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
    this.addTeamsService.createTeam(teamName).subscribe(response => {
      this.newTeam = '';
      this.getData();
    }, error => {
      if (error.status === 200) {
        this.newTeam = '';
        this.getData();
      } else {
        console.log(error.error)
      }
    });
  }
}
