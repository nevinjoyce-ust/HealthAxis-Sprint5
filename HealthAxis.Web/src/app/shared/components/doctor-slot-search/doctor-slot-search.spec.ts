import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DoctorSlotSearch } from './doctor-slot-search';

describe('DoctorSlotSearch', () => {
  let component: DoctorSlotSearch;
  let fixture: ComponentFixture<DoctorSlotSearch>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [DoctorSlotSearch],
    }).compileComponents();

    fixture = TestBed.createComponent(DoctorSlotSearch);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
