import React, { Component, Fragment } from 'react';
import './App.css';

import { graphql, QueryRenderer, createRefetchContainer } from 'react-relay';
import modernEnvironment from './environment';
import RelayRenderContainer from './RelayRenderContainer';

import getStateFromDOM from './getStateFromDOM';

import { BrowserRouter, Switch, Route, Link } from 'react-router-dom';
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';

import Dashboard from './Dashboard';
import Thread from './Thread';
import Signup from './Signup';
import Login from './Login';

const sessionToken = window.localStorage.getItem('SessionToken');
class App extends Component {
  constructor(props) {
    super(props);
    this.initialState = getStateFromDOM('app-state');
    this.state = {
      isAuthenticated: !!sessionToken,
      user: props.data.user,
    };
    this.onAuthentication = this.onAuthentication.bind(this);
    this.onLogout = this.onLogout.bind(this);
    this.refetchData = this.refetchData.bind(this);
  }

  componentDidUpdate(prevProps, prevState, snapshot) {
    console.log({
      prevProps,
      prevState,
      snapshot,
    });
  }

  onAuthentication(user) {
    this.setState({
      user,
      isAuthenticated: true,
    });
  }

  onLogout(e) {
    e.preventDefault();
    window.localStorage.removeItem('SessionToken');
    this.setState({ isAuthenticated: false, user: null });
    return false;
  }

  refetchData() {
    this.props.relay.refetch(
      { token: sessionToken },
      null,
      () => console.log('done refetching app'),
      { force: true }
    );
  }

  render() {
    const { data } = this.props;
    const { user, isAuthenticated } = this.state;
    return (
      <BrowserRouter basename={this.initialState.basename}>
        <MuiThemeProvider>
          <div className="App">
            <header className="App-header">
              <h1 className="App-title">Messenger</h1>
              {
                user && isAuthenticated && 
                <p>
                  Welcome {user.firstname}{' '}{user.lastname}
                  <button className="sign-out" onClick={this.onLogout}>Log out</button>
                </p>
              }
            </header>
            <div className="container">
              {
                !isAuthenticated &&
                <div>
                  <Link to="/login">Log in</Link>
                  {' '}
                  /
                  {' '}
                  <Link to="/signup">Sign up</Link>
                  <p>Start messaging your contacts by signing up!</p>
                </div>
              }
              <Switch>
                {
                  isAuthenticated &&
                  <Fragment>
                    <Route
                      exact
                      path="/"
                      render={() => <Dashboard data={data} isAuthenticated={isAuthenticated} />}
                    />
                    <Route
                      exact
                      path="/thread/:slug"
                      render={props => <Thread refetchData={this.refetchData} userId={user.id} {...props} />}
                    />
                  </Fragment>
                }
                {
                  this.state.isAuthenticated === false &&
                  <Fragment>
                    <Route
                      exact
                      path="/signup"
                      render={() => <Signup />}
                    />
                    <Route
                      exact
                      path="/login"
                      render={() => <Login onAuthentication={this.onAuthentication} />}
                    />
                  </Fragment>
                }
              </Switch>
            </div>
          </div>
        </MuiThemeProvider>
      </BrowserRouter>
    );
  }
}

const RefetchableApp = createRefetchContainer(
  App,
  graphql`
    fragment App on Query
    @argumentDefinitions(
      token: { type: String }
    ) {
      ...UserList
      ...ThreadList
      user(token: $token) {
        id
        firstname
        lastname
        email
      }
    }
  `,
  graphql`
    query AppRefetchQuery(
      $token: String
    ) {
      ...App
        @arguments(token: $token)
    }
  `
);

const query = graphql`
  query AppQuery($token: String) {
    ...App
      @arguments(token: $token)
  }
`;

class AppRenderer extends Component {
  state = {
    error: false,
  }

  componentDidCatch() {
    this.setState({ error: true });
  }
  render() {
    if (this.state.error) {
      return <p>Something went wrong!</p>
    }

    return (
      <QueryRenderer
        environment={modernEnvironment}
        query={query}
        variables={{ token: sessionToken }}
        render={RelayRenderContainer(renderProps => {
          return <RefetchableApp {...renderProps} />;
        })}
      />
    );
  }
}

export default AppRenderer;
