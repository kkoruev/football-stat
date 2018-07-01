import { Component, OnInit } from '@angular/core';
import { Match } from '../types/match';
import { AddMatchesService } from "../admin/add-matches/add-matches.service";
import { UserService } from "../user.service";
import { ActivatedRoute, Router } from "@angular/router";
import { SharedTokenService } from "../shared/shared-token.service";
import { PredictionService } from "./prediction.service";
import { Prediction } from "../types/prediction";
import { UserPrediction } from "../types/user_prediction";


@Component({
  selector: 'app-predictions',
  templateUrl: './predictions.component.html',
  styleUrls: ['./predictions.component.css']
})
export class PredictionsComponent implements OnInit {

  matches: Match[];

  predictedMatches: UserPrediction[];

  constructor(private addMatchService: AddMatchesService,
              private userService: UserService,
              private router: Router,
              private sharedTokenSerice: SharedTokenService,
              private predictindictionService: PredictionService) { }

  ngOnInit() {
    this.getMatches();
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

  submitPrediction(home_score, away_score, match_id) {
    // alert("CLicked");
    this.predictindictionService.submitResult({home_score, away_score, match_id} as Prediction,
            this.sharedTokenSerice.getToken()).subscribe(
              response => {
                this.sharedTokenSerice.setToken(response.headers.get('X-Auth-Token'));
                this.getMatches();
              }, error => {
                if (error.status === 200){
                  this.sharedTokenSerice.setToken(error.headers.get('X-Auth-Token'));
                  this.getMatches();
                } else if (error.status === 401) {
                  this.router.navigate(['/expired']);
                } else {
                  console.log(error);
                }
              }
            );
  }

  getMatches() {
    this.addMatchService.getUserMatches(this.sharedTokenSerice.getToken())
    .subscribe(
      response => {
        this.sharedTokenSerice.setToken(response.headers.get('X-Auth-Token'));
        this.matches = response.body;
        this.getUserPredictions();
      }, error => {
        if (error.status === 401) {
          this.router.navigate(['/expired']);
        }
      }
    );
  }

  getUserPredictions() {
    this.predictindictionService.getUserPredictions(this.sharedTokenSerice.getToken())
    .subscribe(
      response => {
        this.sharedTokenSerice.setToken(response.headers.get('X-Auth-Token'));
        this.predictedMatches = response.body;
      }, error => {
        if (error.status === 401) {
          this.router.navigate(['/expired']);
        }
      }
    );
  }
}
