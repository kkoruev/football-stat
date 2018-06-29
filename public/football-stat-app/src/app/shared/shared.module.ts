import { NgModule, ModuleWithProviders } from '@angular/core';
import { CommonModule } from '@angular/common';
import { SharedTokenService, TokenConfig } from "./shared-token.service";

@NgModule({
  imports: [
    CommonModule
  ],
  providers: [ SharedTokenService ],
  declarations: []
})
export class SharedModule {
  static forRoot(config: TokenConfig): ModuleWithProviders {
    return {
      ngModule: SharedModule,
      providers: [
        {provide: TokenConfig, useValue: config}
      ]
    }
  }
}
