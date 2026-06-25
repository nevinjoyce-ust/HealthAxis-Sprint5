import { ComponentFixture, TestBed } from '@angular/core/testing';

import { Trial } from './trial';

describe('Trial', () => {
  let component: Trial;
  let fixture: ComponentFixture<Trial>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [Trial],
    }).compileComponents();

    fixture = TestBed.createComponent(Trial);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
