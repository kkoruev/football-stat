import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule } from '@angular/forms';

import { AdminRoutingModule } from './admin-routing.module';

import { AddTeamsService } from './add-teams/add-teams.service';

import { AddTeamsComponent } from './add-teams/add-teams.component';
import { AdminComponent } from './admin.component';

@NgModule({
  imports: [
    CommonModule,
    BrowserModule,
    AdminRoutingModule,
    FormsModule
  ],
  declarations: [AddTeamsComponent, AdminComponent],
  providers: [
    AddTeamsService
  ]
})
export class AdminModule { }
