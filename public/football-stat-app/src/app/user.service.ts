import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { HttpErrorResponse } from '@angular/common/http';

import { catchError, map, tap } from 'rxjs/operators';

import { Observable } from 'rxjs/Observable';
import { of } from 'rxjs/observable/of';
import { ErrorObservable } from 'rxjs/observable/ErrorObservable';

import { User } from './user'

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
    var params = new HttpParams().set('email', email).set('password', password);
    return this.http.post(this.loginUrl, params)
      .pipe(
        catchError(this.handleError)
      )
  }

  register(user: User): Observable<any> {
    return this.http.post(this.registerUrl, user)
      .pipe(
        catchError(this.handleError)
      )
  }
  

  private handleError(error: HttpErrorResponse) {
    if (error.error instanceof ErrorEvent) {
      // A client-side or network error occurred. Handle it accordingly.
      console.error('An error occurred:', error.error.message);
    } else {
      // The backend returned an unsuccessful response code.
      // The response body may contain clues as to what went wrong,
      console.error(
        `Backend returned code ${error.status}, ` +
        `body was: ${error.error}`);
    }
    // return an ErrorObservable with a user-facing error message
    return new ErrorObservable(
      'Something bad happened; please try again later.');
  };

}