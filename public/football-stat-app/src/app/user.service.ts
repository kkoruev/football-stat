import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { HttpErrorResponse } from '@angular/common/http';

import { catchError, map, tap } from 'rxjs/operators';

import { Observable } from 'rxjs/Observable';
import { of } from 'rxjs/observable/of';
import { ErrorObservable } from 'rxjs/observable/ErrorObservable';

import { User } from './types/user';
import { Session } from "./types/session";
import { UserPoints } from "./types/user_points";

const httpOptions = {
  headers: new HttpHeaders({
    'Content-Type':  'application/json',
  })
};

@Injectable()
export class UserService {

  private apiUril = 'http://127.0.0.1:9393';
  private loginUrl = this.apiUril + '/login';
  private registerUrl = this.apiUril + '/register';

  constructor(
    private http: HttpClient,
  ) { }

  login(email: string, password: string): Observable<any> {
    var user = {email: email, password: password};
    return this.http.post(this.loginUrl, user, {observe: 'response'});
  }

  register(user: User): Observable<any> {
    return this.http.post(this.registerUrl, user)
  }

  usersStanding(token) {
    var headers = new HttpHeaders();
    headers = headers.set('X-Auth-Token', token);
    return this.http.get<UserPoints[]>(this.apiUril + '/standing',
                      {observe: 'response', headers: headers});
  }
}
