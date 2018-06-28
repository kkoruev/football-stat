import { Component, OnInit } from '@angular/core';
import { AddMatchesService } from "../add-matches/add-matches.service";
import { Match } from "../../types/match";
import { Result }  from '../../types/result'

import { ResultsService } from "./results.service"
@Component({
  selector: 'app-add-result',
  templateUrl: './add-result.component.html',
  styleUrls: ['./add-result.component.css']
})
export class AddResultComponent implements OnInit {


  matches: Match[];

  error: string;

  constructor(private addMatchService: AddMatchesService,
              private resultService: ResultsService) { }

  ngOnInit() {
    this.getMatches();
  }

  getMatches() {
    this.addMatchService.getMatches().subscribe(
      response => {
        this.matches = response;
        console.log(this.matches);
      }
    );
  }

  submitResult(id, home_score, away_score) {
    this.resultService.submitResult(id, {home_score, away_score} as Result)
                        .subscribe(response => {
                            this.getMatches();
                          }, error => {
                            if (error.status === 200) {
                              this.getMatches();
                              console.log("SUccess")
                            } else {
                              this.error = error.error;
                              console.log(error);
                            }

                          });
  }

}
