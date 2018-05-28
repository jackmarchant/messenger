import React, { Component, Fragment } from 'react';
import './App.css';

import { graphql, QueryRenderer } from 'react-relay';
import modernEnvironment from './environment';
import RelayRenderContainer from './RelayRenderContainer';

import getStateFromDOM from './getStateFromDOM';

import { BrowserRouter, Switch, Route } from 'react-router-dom';
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
  }

  onAuthentication(user) {
    this.setState({
      user,
      isAuthenticated: true,
    });
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
              <p>Welcome {user.firstname}{' '}{user.lastname}</p>
            </header>
            <div className="container">
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
                      render={props => <Thread userId={user.id} {...props} />}
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


const query = graphql`
  query AppQuery($token: String!) {
    ...UserList
    ...ThreadList
    user(token: $token) {
      id
      firstname
      lastname
      email
    }
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
          return <App {...renderProps} />;
        })}
      />
    );
  }
}

export default AppRenderer;
