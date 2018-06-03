import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AddTeamsComponent } from './add-teams/add-teams.component';
import { AdminComponent } from './admin.component';

export const adminRoutes: Routes = [
    {
        path: 'admin',
        component: AdminComponent,
        children: [
            {
                path: 'add-teams',
                component: AddTeamsComponent
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
