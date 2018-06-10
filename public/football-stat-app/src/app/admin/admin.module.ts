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

@NgModule({
  imports: [
    CommonModule,
    BrowserModule,
    AdminRoutingModule,
    FormsModule
  ],
  declarations: [AddTeamsComponent, AdminComponent, AddMatchesComponent],
  providers: [
    AddTeamsService,
    AddMatchesService
  ]
})
export class AdminModule { }
