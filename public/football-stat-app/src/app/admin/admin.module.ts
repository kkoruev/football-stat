import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule } from '@angular/forms';

import { AdminRoutingModule } from './admin-routing.module';

import { AddTeamsService } from './add-teams/add-teams.service';

import { AddTeamsComponent } from './add-teams/add-teams.component';
import { AdminComponent } from './admin.component';
import { AddMatchesComponent } from './add-matches/add-matches.component';
import { AddMatchesService } from "./add-matches/add-matches.service";
import { AddResultComponent } from './add-result/add-result.component';
import { ResultsService } from './add-result/results.service'

@NgModule({
  imports: [
    CommonModule,
    BrowserModule,
    AdminRoutingModule,
    FormsModule
  ],
  declarations: [AddTeamsComponent, AdminComponent, AddMatchesComponent, AddResultComponent],
  providers: [
    AddTeamsService,
    AddMatchesService,
    ResultsService
  ]
})
export class AdminModule { }
