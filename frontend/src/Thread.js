import React, { Fragment } from 'react';
import { NavLink } from 'react-router-dom';
import { graphql, QueryRenderer } from 'react-relay';
import modernEnvironment from './environment';
import RelayRenderContainer from './RelayRenderContainer';

const Thread = ({ name }) => {
  return (
    <Fragment>
      <h2>{name}</h2>
      <NavLink to="/">Back</NavLink>
    </Fragment>
  );
};

const query = graphql`
  query ThreadQuery($slug: String!) {
    thread(slug: $slug) {
      id
      name
      messages {
        content
      }
    }
  }
`;

const ThreadRenderer = ({ match }) => {
  return (
    <QueryRenderer
      environment={modernEnvironment}
      query={query}
      variables={{slug: match.params.slug}}
      render={RelayRenderContainer(props => {
        return <Thread {...props.data.thread} />;
      })}
    />
  );
};

export default ThreadRenderer;