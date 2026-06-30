import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { Home } from './pages/home/home';
import { Login } from './pages/login/login';

const routes: Routes = [
  {
    path: '',
    component: Home,
    title: 'HealthAxis'
  },
  {
    path: 'login',
    component: Login,
    title: 'Login - HealthAxis'
  },
  {
    path: '**',
    redirectTo: ''
  }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
