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

  match: Match = {
    home_team: "",
    away_team: "",
    date: "",
    gameweek: ""
  };

  matches: Match[];

  constructor(private addTeamsService: AddTeamsService,
              private addMatchService: AddMatchesService) { }

  ngOnInit() {
    this.getTeams();
    this.getMatches();
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
    this.addMatchService.submitMatch(this.match)
                        .subscribe(response => {

                          }, error => {
                            if (error.status === 200) {
                              this.getMatches();
                              console.log("SUccess")
                            } else {
                              console.log("failure")
                            }

                          });
  }

  getTeams() {
    this.addTeamsService.getTeams().subscribe(
      response => {
        this.teams = response;
        console.log(this.teams);
      }
    );
  }

  getMatches() {
    this.addMatchService.getMatches().subscribe(
      response => {
        this.matches = response;
        console.log(this.matches);
      }
    );
  }

}
