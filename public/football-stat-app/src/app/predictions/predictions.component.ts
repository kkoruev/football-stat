import { Component, OnInit } from '@angular/core';
import { Match } from '../types/match';
import { AddMatchesService } from "../admin/add-matches/add-matches.service";
import { UserService } from "../user.service";
import { ActivatedRoute } from "@angular/router";
import { SharedTokenService } from "../shared/shared-token.service";


@Component({
  selector: 'app-predictions',
  templateUrl: './predictions.component.html',
  styleUrls: ['./predictions.component.css']
})
export class PredictionsComponent implements OnInit {

  matches: Match[];

  constructor(private addMatchService: AddMatchesService,
              private userService: UserService,
              private route: ActivatedRoute,
              private sharedTokenSerice: SharedTokenService) { }

  ngOnInit() {
    this.getMatches();
  }


  getMatches() {
    this.addMatchService.getUserMatches(this.sharedTokenSerice.getToken())
    .subscribe(
      response => {
        this.sharedTokenSerice.setToken(response.headers.get('X-Auth-Token'));
        this.matches = response.body;
      }, errpr => {
        console.log("Hros")
      }
    );
  }
}
