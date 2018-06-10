import { Component, OnInit } from '@angular/core';
import { Team } from "../../types/team";
import { AddTeamsService } from "../add-teams/add-teams.service";
import { AddMatchesService } from "./add-matches.service";
import { Match } from "../../types/match";

declare var jquery:any;
declare var $ :any;

@Component({
  selector: 'app-add-matches',
  templateUrl: './add-matches.component.html',
  styleUrls: ['./add-matches.component.css']
})
export class AddMatchesComponent implements OnInit {

  teams: Team[];
  matches: any;
  matches_iteration = [];
  home_teams = [];
  away_teams = [];
  gameweekes = [];
  dates = [];

  constructor(private addTeamsService: AddTeamsService,
              private addMatchService: AddMatchesService) { }

  ngOnInit() {
    this.getTeams();
    this.matches = 0;
    console.log(this.matches)
    this.refreshMatches();
  }

  addMatch() {
    this.matches+=1;
    this.refreshMatches();
  }

  refreshMatches() {
    this.matches_iteration = Array.apply(null,  {
      length: this.matches
    }).map(Number.call, Number);
  }

  submitMatch(match_row: number) {
    var home_team = this.home_teams[match_row]
    var away_team = this.away_teams[match_row]
    var gameweek = this.gameweekes[match_row]
    var date = this.dates[match_row]
    this.addMatchService.submitMatch({home_team, away_team, gameweek, date} as Match)
                        .subscribe(response => {
                            this.matches-=1;
                            this.matches_iteration.splice(match_row, 1);
                          }, error => {
                            if (error.status === 200) {
                              console.log("SUccess")
                              this.matches-=1;
                              this.matches_iteration.splice(match_row, 1);
                            } else {
                              console.log("failure")
                            }

                          });
  }

  // removeMatch() {
  //   this.matches-=1;
  //   this.matches_iteration = Array.apply(null,  {
  //     length: this.matches
  //   }).map(Number.call, Number);
  // }

  getTeams() {
    this.addTeamsService.getTeams().subscribe(
      response => {
        this.teams = response;
        console.log(this.teams);
      }
    );
  }

}
