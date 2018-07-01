import { Injectable } from '@angular/core';
import { HttpHeaders, HttpClient } from "@angular/common/http";
import { Match } from "../../types/match";


@Injectable()
export class AddMatchesService {

  private apiUrl = 'http://127.0.0.1:9393/';

  constructor(
    private http: HttpClient,
  ) { }

  submitMatch(match: Match, token) {
    var headers = new HttpHeaders();
    headers = headers.set('X-Auth-Token', token);
    return this.http.post(this.apiUrl + 'admin/matches', match,
              {observe: 'response', headers: headers});
  }

  getMatches(token) {
    var headers = new HttpHeaders();
    headers = headers.set('X-Auth-Token', token);
    return this.http.get<Match[]>(this.apiUrl + 'admin/matches',
              {observe: 'response', headers: headers});
  }

  getUserMatches(token) {
    var headers = new HttpHeaders();
    headers = headers.set('X-Auth-Token', token);
    return this.http.get<Match[]>(this.apiUrl + "/matches", {observe: 'response', headers: headers});
  }
}
