import { Injectable } from '@angular/core';
import { HttpHeaders, HttpClient } from "@angular/common/http";
import { Result } from '../../types/result'

const httpOptions = {
  headers: new HttpHeaders({
    'Content-Type':  'application/json',
  })
};

@Injectable()
export class ResultsService {
  private apiUrl = 'http://127.0.0.1:9393/';

  constructor(private http: HttpClient) { }

  submitResult(match_id, result: Result) {
    return this.http.post(this.apiUrl + 'admin/matches/' + match_id + '/results', result);
  }

}
