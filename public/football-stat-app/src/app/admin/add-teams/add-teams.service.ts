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

  getTeams() {
    return this.http.get<Team[]>(this.apiUrl + 'admin/teams');
  }

  createTeam(teamName: string) {
    return this.http.post(this.apiUrl + 'admin/teams', {name: teamName});
  }

  removeTeam(teamName: string){
    return this.http.delete(this.apiUrl + 'admin/teams/' + teamName);
  }

}
