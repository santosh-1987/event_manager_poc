# Event Manager

# Objective:

Your task is to create a simple web-based application using Ruby on Rails (RoR) that
integrates with the Iterable.io API. The application will have two buttons, each responsible
for creating a different event associated with a user. After the events have been created, the
application should search through them, and for every Event B, an email notification should
be sent via Iterable.io API.

# Requirements:

- User Interface:
    - Develop a UI using RoR with two buttons:
    - Create Event A: When clicked, creates an instance of Event A associated with
      a user in Iterable.io.
    - Create Event B: When clicked, creates an instance of Event B associated with
      a user in Iterable.io.

## Iterable.io Integration:

- Integrate the application with Iterable.io API to create events and manage
  users.
- Use the Iterable.io API to send email notifications for Event B.
- Mocking Iterable.io
    - API: Ensure that the interaction with the Iterable.io
    - API is mocked out using over-the-wire mocks for testing purposes

## Code Structure:

- Your code should be modular, readable, and maintainable in Ruby on Rails.
- Include appropriate comments and documentation.

## Start the APP
`STUB=true bin/dev`