import { Injectable } from '@angular/core';
import { Router } from '@angular/router';

@Injectable()
export class LoginService {

  constructor(
    private router: Router
  ) { }

  login(email: string, password: string): void {
    this.router.navigate(['/register']);
  }
}
