import { Injectable } from '@angular/core';
import { HttpHeaders, HttpClient } from "@angular/common/http";
import { Match } from "../../types/match";

const httpOptions = {
  headers: new HttpHeaders({
    'Content-Type':  'application/json',
  })
};

@Injectable()
export class AddMatchesService {

  private apiUrl = 'http://127.0.0.1:9393/';

  constructor(
    private http: HttpClient,
  ) { }

  submitMatch(match: Match) {
    return this.http.post(this.apiUrl + 'admin/matches', match);
  }

  getMatches() {
    return this.http.get<Match[]>(this.apiUrl + 'admin/matches');
  }

  getUserMatches(userId) {
    return this.http.get<Match[]>(this.apiUrl + "/matches");
  }
}
