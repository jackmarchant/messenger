import React, { Component } from 'react';
import './App.css';

import { graphql, QueryRenderer } from 'react-relay';
import modernEnvironment from './environment';
import RelayRenderContainer from './RelayRenderContainer';

import getStateFromDOM from './getStateFromDOM';

import { BrowserRouter, Switch, Route } from 'react-router-dom';
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';

import Dashboard from './Dashboard';
import Thread from './Thread';

class App extends Component {
  constructor(props) {
    super(props);
    this.initialState = getStateFromDOM('app-state');
  }
  render() {
    const { data } = this.props;
    return (
      <BrowserRouter basename={this.initialState.basename}>
        <MuiThemeProvider>
          <div className="App">
            <header className="App-header">
              <h1 className="App-title">Messenger</h1>
            </header>
            <div className="container">
              <Switch>
                <Route
                  exact
                  path="/"
                  render={() => <Dashboard data={data} />}
                />
                <Route
                  exact
                  path="/thread/:slug"
                  render={Thread}
                />
              </Switch>
            </div>
          </div>
        </MuiThemeProvider>
      </BrowserRouter>
    );
  }
}


const query = graphql`
  query AppQuery {
    ...UserList
    ...ThreadList
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
        variables={{}}
        render={RelayRenderContainer(renderProps => {
          return <App {...renderProps} />;
        })}
      />
    );
  }
}

export default AppRenderer;
