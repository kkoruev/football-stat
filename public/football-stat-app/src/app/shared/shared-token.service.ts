import { Injectable, Optional} from '@angular/core';

export class TokenConfig {
  token = '';
}

@Injectable()
export class SharedTokenService {

  private token: string;

  constructor(@Optional() config: TokenConfig) {
    if(config) {
      this.token = config.token;
    }
  }

  getToken() {
    return this.token;
  }

  setToken(token) {
    this.token = token;
  }

}
