import { BrowserModule } from '@angular/platform-browser';
import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';

import { AppRoutingModule } from './app-routing.module';
import { AdminModule } from './admin/admin.module';

import { AppComponent } from './app.component';
import { LoginComponent } from './login/login.component';
import { RegisterComponent } from './register/register.component';

import { UserService } from './user.service';
import { PredictionsComponent } from './predictions/predictions.component';
import { AddMatchesService } from "./admin/add-matches/add-matches.service";
import { SharedModule } from "./shared/shared.module";
import { SessionExpiredComponent } from './session-expired/session-expired.component';
import { PredictionService } from "./predictions/prediction.service";
import { StandingComponent } from './standing/standing.component';
import { StatisticsComponent } from './statistics/statistics.component';


@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    RegisterComponent,
    PredictionsComponent,
    SessionExpiredComponent,
    StandingComponent,
    StatisticsComponent
  ],
  imports: [
    BrowserModule,
    CommonModule,
    AppRoutingModule,
    FormsModule,
    HttpClientModule,
    AdminModule,
    SharedModule.forRoot({token: ''})
  ],
  providers: [UserService, AddMatchesService, PredictionService],
  bootstrap: [AppComponent]
})
export class AppModule { }
