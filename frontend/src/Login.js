import React, { Fragment } from 'react';
import NavLink from 'react-router-dom/NavLink';
import withRouter from 'react-router-dom/withRouter';
import TextField from 'material-ui/TextField';
import RaisedButton from 'material-ui/RaisedButton';
import LoginMutation from './LoginMutation';

const Error = () => {
  return (
    <Fragment>
      <p>Unable to login. Either your login credentials are incorrect, or the user doesn't exist.</p>
      <p>If you don't have a login, please <NavLink to="/signup">Sign up</NavLink></p>
    </Fragment>
  );
};

class Login extends React.Component {
  constructor(props) {
    super(props);
    this.getInitialState = this.getInitialState.bind(this);
    this.onSubmit = this.onSubmit.bind(this);
    this.onChange = this.onChange.bind(this);
    this.state = this.getInitialState();
  }
  
  getInitialState() {
    return {
      email: '',
      password: '',
    };
  }

  onSubmit(event) {
    const { history } = this.props;
    event.preventDefault();
    LoginMutation.commit(this.state)
    .then(result => {
      if (result.login === null) {
        return this.setState({ error: "Invalid login credentials or user doesn't exist" });
      }

      // TODO: change to use context
      window.localStorage.setItem('SessionToken', result.login.session.token);
      this.setState(this.getInitialState());
      history.push('/');
    });
    return false;
  }

  onChange(key) {
    return (e, value) => {
      return this.setState({[key]: value});
    }
  }

  render() {
    const { email, password, error } = this.state;

    return (
      <Fragment>
        <NavLink to="/">Back</NavLink>
        <div>
          <h2>Log in</h2>
          {error && <Error />}
          <form onSubmit={this.onSubmit} autoComplete="off">
            <TextField
              autoComplete="off"
              id="email"
              name="email"
              floatingLabelText="Your email"
              fullWidth
              onChange={this.onChange('email')}
              value={email}
              type="email"
            />
            <TextField
              autoComplete="off"
              id="password"
              name="password"
              floatingLabelText="Your password"
              fullWidth
              onChange={this.onChange('password')}
              value={password}
              type="password"
            />
            <RaisedButton primary type="submit" onClick={this.onSubmit}>Submit</RaisedButton>
          </form>
        </div>
      </Fragment>
    );
  }
}

export default withRouter(Login);