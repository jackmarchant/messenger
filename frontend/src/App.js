import React, { Component } from 'react';
import './App.css';

import { graphql, QueryRenderer } from 'react-relay';
import modernEnvironment from './environment';
import RelayRenderContainer from './RelayRenderContainer';

class App extends Component {
  render() {
    return (
      <div className="App">
        <header className="App-header">
          <h1 className="App-title">Messenger</h1>
        </header>
        <div>
          <h2>Users</h2>
          {this.props.data.users.map((user, index) => {
            return (
              <div key={`user-${index}`}>
                <p>Email: {user.email}</p>
                <p>Firstname: {user.firstname}</p>
                <p>Lastname: {user.lastname}</p>
                <p>ID: {user.id}</p>
                <hr />
              </div>
            );
          })}
        </div>
      </div>
    );
  }
}

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

    const query = graphql`
      query AppQuery {
        users {
          id
          firstname
          lastname
          email
        }
      }
    `;

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
