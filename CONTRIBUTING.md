# Contributing Guidelines

## Reporting issues

Please be the most descriptive in your issue when describing your problem.

Try to answer the following questions:
- What did you do?
- What did you expect to happen?
- What happened instead?

Make sure to include as much relevant information as possible. Ruby version, Rails version, PostgreSQL version, OS version and any stack traces you have are very valuable.

### Security issues

If you have found a security related issue, please do not file an issue on GitHub or send a PR addressing the issue.

Contact the author directly (erick.tmr@outlook.com). You will be given public credit for your disclosure.

## Pull Requests

### Steps

1. **Fork** [the repo](https://github.com/erickm93/tk-bank-api)
2. Grab dependencies: `bundle install`
3. Make sure everything is working: `bundle exec rspec`
4. Make your changes
5. **Test your changes!** Your patch won't be accepted if it doesn't have tests.
6. **Document any change in behaviour**. Make sure the README and any other
  relevant documentation are kept up-to-date.
7. Create a Pull Request
8. Celebrate!!!!!

## Nice to have practices

- Create topic branches.
  
  Please don't ask us to pull from your master branch.

- One pull request per feature.

  If you want to do more than one thing, send
  multiple pull requests.

- Send coherent history.

  Make sure each individual commit in your pull
  request is meaningful. If you had to make multiple intermediate commits while
  developing, please squash them before sending them to us.
