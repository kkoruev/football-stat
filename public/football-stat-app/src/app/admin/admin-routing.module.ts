import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AddTeamsComponent } from './add-teams/add-teams.component';
import { AdminComponent } from './admin.component';
import { AddMatchesComponent } from "./add-matches/add-matches.component";

export const adminRoutes: Routes = [
    {
        path: 'admin',
        component: AdminComponent,
        children: [
            {
                path: 'add-teams',
                component: AddTeamsComponent
            },
            {
              path: 'add-matches',
              component: AddMatchesComponent
            }
        ]
    }
]

@NgModule({
    imports:[
        RouterModule.forChild(adminRoutes)
    ],
    exports: [
        RouterModule
    ]
})
export class AdminRoutingModule {}
