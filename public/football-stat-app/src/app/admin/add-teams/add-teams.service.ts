import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { HttpErrorResponse } from '@angular/common/http';

import { Team } from '../../types/team';

const httpOptions = {
  headers: new HttpHeaders({
    'Content-Type':  'application/json',
  })
};

@Injectable()
export class AddTeamsService {

  private apiUrl = 'http://127.0.0.1:9393/';

  constructor(
    private http: HttpClient,
  ) { }

  getTeams(token) {
    var headers = new HttpHeaders();
    headers = headers.set('X-Auth-Token', token);
    return this.http.get<Team[]>(this.apiUrl + 'admin/teams',
                      {observe: 'response', headers: headers});
  }

  createTeam(teamName: string, token) {
    var headers = new HttpHeaders();
    headers = headers.set('X-Auth-Token', token);
    return this.http.post(this.apiUrl + 'admin/teams', {name: teamName},
                      {observe: 'response', headers: headers});
  }

  removeTeam(teamName: string, token){
    var headers = new HttpHeaders();
    headers = headers.set('X-Auth-Token', token);
    return this.http.delete(this.apiUrl + 'admin/teams/' + teamName,
                      {observe: 'response', headers: headers});
  }

}
