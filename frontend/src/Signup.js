import React, { Fragment } from 'react';
import Link from 'react-router-dom/Link';
import withRouter from 'react-router-dom/withRouter';
import TextField from 'material-ui/TextField';
import RaisedButton from 'material-ui/RaisedButton';
import CreateUserMutation from './CreateUserMutation';

class Signup extends React.Component {
  constructor(props) {
    super(props);
    this.state = this.getInitialState();
    this.onSubmit = this.onSubmit.bind(this);
    this.onChange = this.onChange.bind(this);
    this.getInitialState = this.getInitialState.bind(this);
  }

  getInitialState() {
    return {
      email: '',
      password: '',
      firstname: '',
      lastname: '',
    };
  }

  onSubmit(event) {
    const { history } = this.props;
    event.preventDefault();
    CreateUserMutation.commit(this.state)
    .then(result => {
      this.setState(this.getInitialState());
      history.push('/login');
    });
    return false;
  }

  onChange(key) {
    return (e, value) => this.setState({[key]: value});
  }

  render() {
    return (
      <Fragment>
        <Link to="/">Back</Link>
        <div>
          <h2>Sign Up</h2>
          <form onSubmit={this.onSubmit} autoComplete="off">
            <TextField
              autoComplete="off"
              id="firstname"
              name="firstname"
              floatingLabelText="Your first name"
              fullWidth
              onChange={this.onChange('firstname')}
              value={this.state.firstname}
            />
            <TextField
              autoComplete="off"
              id="lastname"
              name="lastname"
              floatingLabelText="Your last name"
              fullWidth
              onChange={this.onChange('lastname')}
              value={this.state.lastname}
            />
            <TextField
              autoComplete="off"
              id="email"
              name="email"
              floatingLabelText="Your email"
              fullWidth
              onChange={this.onChange('email')}
              value={this.state.email}
              type="email"
            />
            <TextField
              autoComplete="off"
              id="password"
              name="password"
              floatingLabelText="Your password"
              fullWidth
              onChange={this.onChange('password')}
              value={this.state.password}
              type="password"
            />
            <RaisedButton primary type="submit" onClick={this.onSubmit}>Submit</RaisedButton>
          </form>
        </div>
      </Fragment>
    );
  }
}

export default withRouter(Signup);