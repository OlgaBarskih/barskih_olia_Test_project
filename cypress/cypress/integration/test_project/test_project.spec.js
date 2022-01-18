/// <reference types = "cypress" />
var BaseURL = 'https://www.globalsqa.com/samplepagetest/'
describe('Form', () => {
   Cypress.on('uncaught:exception', (err, runnable) => {
       return false;
   });
   it('Send form with only required valid test data', () => {
    cy.visit(BaseURL);
    cy.get('#g2599-name').type('User')
    cy.get('#g2599-email').type('user@email.com')
    cy.get('#g2599-experienceinyears').select('1-3')
    cy.get('#contact-form-comment-g2599-comment').type('hello!')
    cy.get('.pushbutton-wide').click()
    cy.get('#contact-form-2599 > h3').should('contain','Message Sent (go back)')
});
it('Send form with not valid password', () => {
    cy.visit(BaseURL);
    cy.get('#g2599-name').type('User')
    cy.get('#g2599-email').type('hgdhkjfhl@vhkb')
    cy.get('#g2599-experienceinyears').select('1-3')
    cy.get('#contact-form-comment-g2599-comment').type('hello!')
    cy.get('.pushbutton-wide').click()
    cy.get('.form-error-message').should('contain','Email requires a valid email address')
});
it('Send form with empty fields', () => {
    cy.visit(BaseURL);
    cy.get('.pushbutton-wide').click()
    cy.get('input:invalid').should('have.length', 2)
});
})