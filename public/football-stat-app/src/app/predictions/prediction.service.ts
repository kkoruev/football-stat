import { Injectable } from '@angular/core';
import { HttpHeaders, HttpClient } from "@angular/common/http";
import { Prediction } from "../types/prediction"
import { UserPrediction } from "../types/user_prediction";

const httpOptions = {
  headers: new HttpHeaders({
    'Content-Type':  'application/json',
  })
};

@Injectable()
export class PredictionService {

  private apiUrl = 'http://127.0.0.1:9393/';

  constructor(
    private http: HttpClient,
  ) { }

  submitResult(prediction: Prediction, token) {
    console.log(token);
    var headers = new HttpHeaders();
    headers = headers.set('X-Auth-Token', token)
    return this.http.post(this.apiUrl + 'predictions', prediction,
                    {observe: 'response', headers: headers});
  }

  getUserPredictions(token) {
    var headers = new HttpHeaders();
    headers = headers.set('X-Auth-Token', token)
    return this.http.get<UserPrediction[]>(this.apiUrl + 'predictions',
                    {observe: 'response', headers: headers});
  }

}
