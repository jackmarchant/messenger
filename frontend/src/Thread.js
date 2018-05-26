import React, { Fragment } from 'react';
import { NavLink } from 'react-router-dom';
import { graphql, QueryRenderer } from 'react-relay';
import modernEnvironment from './environment';
import RelayRenderContainer from './RelayRenderContainer';

import Divider from 'material-ui/Divider';
import './Message.css';

const Message = ({ content }) => {
  return (
    <Fragment>
      <p className="message">{content}</p>
      <Divider />
    </Fragment>
  );
};

const Thread = ({ name, messages }) => {
  return (
    <Fragment>
      <NavLink to="/">Back to threads</NavLink>
      <h2>Your conversation</h2>
      <div className="messages">
        {messages.map((message, key) => <Fragment key={`message-${key}`}><Message {...message} /></Fragment>)}
      </div>
    </Fragment>
  );
};

const query = graphql`
  query ThreadQuery($slug: String!) {
    thread(slug: $slug) {
      id
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