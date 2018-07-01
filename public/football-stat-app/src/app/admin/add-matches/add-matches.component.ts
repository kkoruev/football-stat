import { Component, OnInit } from '@angular/core';
import { Team } from "../../types/team";
import { AddTeamsService } from "../add-teams/add-teams.service";
import { AddMatchesService } from "./add-matches.service";
import { Match } from "../../types/match";
import { SharedTokenService } from "../../shared/shared-token.service";
import { Router } from '@angular/router'

declare var jquery:any;
declare var $ :any;

@Component({
  selector: 'app-add-matches',
  templateUrl: './add-matches.component.html',
  styleUrls: ['./add-matches.component.css']
})
export class AddMatchesComponent implements OnInit {

  teams: Team[];

  match: Match = {
    home_team: "",
    away_team: "",
    date: "",
    gameweek: ""
  };

  matches: Match[];

  finished: boolean;

  constructor(private addTeamsService: AddTeamsService,
              private addMatchService: AddMatchesService,
              private router: Router,
              private sharedTokenService: SharedTokenService) { }

  ngOnInit() {
    this.finished = false;
    this.getTeams();
  }

  refreshMatch() {
    this.match = {
      home_team: "",
      away_team: "",
      date: "",
      gameweek: ""
    };
  }

  submitMatch() {
    this.addMatchService.submitMatch(this.match, this.sharedTokenService.getToken())
                        .subscribe(response => {
                              this.sharedTokenService.setToken(response.headers.get('X-Auth-Token'))
                          }, error => {
                            if (error.status === 200) {
                              this.sharedTokenService.setToken(error.headers.get('X-Auth-Token'))
                              this.getMatches();
                              console.log("SUccess")
                            } else if (error.status === 401) {
                              this.router.navigate(['/expired']);
                            } else {

                            }
                          });
  }

  getTeams() {
    console.log(this.sharedTokenService.getToken())
    console.log("bEFORE " + this.sharedTokenService.getToken())
    this.addTeamsService.getTeams(this.sharedTokenService.getToken()).subscribe(
      response => {
        this.sharedTokenService.setToken(response.headers.get('X-Auth-Token'))
        this.teams = response.body;
        console.log(this.teams);
        this.getMatches();
      }, error => {
        if(error.status === 401) {
          this.router.navigate(['/expired']);
        }
      }
    );
  }

  getMatches() {
    this.addMatchService.getMatches(this.sharedTokenService.getToken()).subscribe(
      response => {
        this.sharedTokenService.setToken(response.headers.get('X-Auth-Token'))
        this.matches = response.body;
        console.log(this.matches);
      }, error => {
        if(error.status === 401) {
          this.router.navigate(['/expired']);
        }
      }
    );
  }

}
