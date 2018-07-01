import { Component, OnInit } from '@angular/core';
import { AddMatchesService } from "../add-matches/add-matches.service";
import { Match } from "../../types/match";
import { Result }  from '../../types/result'

import { ResultsService } from "./results.service"
import { SharedTokenService } from "../../shared/shared-token.service";
import { Router } from "@angular/router";

@Component({
  selector: 'app-add-result',
  templateUrl: './add-result.component.html',
  styleUrls: ['./add-result.component.css']
})
export class AddResultComponent implements OnInit {


  matches: Match[];

  error: string;

  constructor(private addMatchService: AddMatchesService,
              private resultService: ResultsService,
              private router: Router,
              private sharedTokenService: SharedTokenService) { }

  ngOnInit() {
    this.getMatches();
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

  submitResult(id, home_score, away_score) {
    this.resultService.submitResult(id, {home_score, away_score} as Result,
                            this.sharedTokenService.getToken())
                          .subscribe(response => {
                            this.sharedTokenService.setToken(response.headers.get('X-Auth-Token'))
                            this.getMatches();
                          }, error => {
                            if (error.status === 200) {
                              this.sharedTokenService.setToken(error.headers.get('X-Auth-Token'))
                              this.getMatches();
                              console.log("SUccess")
                            } else if(error.status == 401) {
                              this.router.navigate(['/expired']);
                            } else {
                              this.error = error.error;
                            }

                          });
  }

}
