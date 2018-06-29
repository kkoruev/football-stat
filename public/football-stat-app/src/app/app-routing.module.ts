import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule, Routes } from '@angular/router';
import { LoginComponent } from './login/login.component'
import { RegisterComponent } from './register/register.component'
import { PredictionsComponent } from './predictions/predictions.component'
import { AppComponent } from "./app.component";
import { SessionExpiredComponent } from "./session-expired/session-expired.component";


const routes: Routes = [
  { path: 'login', component: LoginComponent },
  { path: 'register', component: RegisterComponent },
  { path: 'predictions', component: PredictionsComponent},
  { path: 'expired', component: SessionExpiredComponent}
];

@NgModule({
  exports: [ RouterModule ],
  imports: [
    CommonModule,
    RouterModule.forRoot(routes)
  ],
  declarations: []
})
export class AppRoutingModule { }
