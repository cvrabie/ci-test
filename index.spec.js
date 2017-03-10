const expect = require('chai').expect;
const logic = require('./logic'); 
describe("maintest", ()=>{
  it("should test", ()=>{
    expect(logic.getName()).to.equal('Hagrid');
  });
});
