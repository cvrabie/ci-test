'use strict';

const supertest = require('supertest');
const expect = require('chai').expect;
const request = supertest('http://microservice:3000');

describe('service', () => {
  describe('GET /', () => {
    it('should be polite', (done) => {
      request.get('/')
        .expect('Content-Type', /html/)
        .expect(200, done);
    });
  });
});

