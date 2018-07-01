import { Component, OnInit } from '@angular/core';
import { Router } from "@angular/router"

@Component({
  selector: 'app-statistics',
  templateUrl: './statistics.component.html',
  styleUrls: ['./statistics.component.css']
})
export class StatisticsComponent implements OnInit {

  constructor(private router: Router) { }

  ngOnInit() {
  }

  predictMatches() {
    this.router.navigate(['predictions']);
  }

  standing(){
    this.router.navigate(['/standing']);
  }

  statistics(){
    this.router.navigate(['/statistics']);
  }

  logout() {
    this.router.navigate(['/login']);
  }

}
