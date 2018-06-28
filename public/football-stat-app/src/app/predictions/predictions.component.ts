import { Component, OnInit } from '@angular/core';
import { Match } from '../types/match';
import { AddMatchesService } from "../admin/add-matches/add-matches.service";


@Component({
  selector: 'app-predictions',
  templateUrl: './predictions.component.html',
  styleUrls: ['./predictions.component.css']
})
export class PredictionsComponent implements OnInit {

  matches: Match[];
  userId: string;

  constructor(private addMatchService: AddMatchesService) { }

  ngOnInit() {
    this.getMatches();
    this.userId = '16';
  }

  getMatches() {
    this.addMatchService.getUserMatches(this.userId).subscribe(
      response => {
        this.matches = response;
        console.log(this.matches);
      }
    );
  }

}
