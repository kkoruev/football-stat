import { TestBed, inject } from '@angular/core/testing';

import { AddMatchesService } from './add-matches.service';

describe('AddMatchesService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [AddMatchesService]
    });
  });

  it('should be created', inject([AddMatchesService], (service: AddMatchesService) => {
    expect(service).toBeTruthy();
  }));
});
