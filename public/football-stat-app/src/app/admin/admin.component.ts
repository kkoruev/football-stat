import { Component, OnInit } from '@angular/core';
import { Router } from "@angular/router";

@Component({
  selector: 'app-admin',
  templateUrl: './admin.component.html',
  styleUrls: ['./admin.component.css']
})
export class AdminComponent implements OnInit {

  constructor(private router: Router) { }

  ngOnInit() {
  }

  addMatches() {
    this.router.navigate(['/admin/add-matches']);
  }

  addResults() {
    this.router.navigate(['/admin/add-result']);
  }

  addTeams() {
    this.router.navigate(['/admin/add-teams']);
  }

  logout() {
    this.router.navigate(['/login']);
  }


}
