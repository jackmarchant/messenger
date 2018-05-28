import React, { Fragment } from 'react';
import { Link } from 'react-router-dom';
import { graphql, QueryRenderer, createRefetchContainer } from 'react-relay';
import modernEnvironment from './environment';
import RelayRenderContainer from './RelayRenderContainer';
import TextField from 'material-ui/TextField';
import CreateMessageMutation from './CreateMessageMutation';

import './Message.css';

const Message = ({ content }) => {
  return (
    <Fragment>
      <p className="message">{content}</p>
    </Fragment>
  );
};

class MessageBox extends React.Component {
  constructor(props) {
    super(props);
    this.sendMessage = this.sendMessage.bind(this);
    this.onSubmit = this.onSubmit.bind(this);
    this.messageField = null;
    this.state = {
      message: '',
    };
  }

  sendMessage(userId, threadId) {
    const content = this.state.message;
    this.setState({ message: '' }, () => {
      CreateMessageMutation.commit({
        userId,
        threadId,
        content,
      }).then(response => {
        this.props.onSendMessage(response);
        this.messageField.input.scrollIntoView();
      });
    });
  }

  onSubmit(e) {
    e.preventDefault();
    this.sendMessage(this.props.userId, this.props.threadId);
    return false;
  }

  render() {
    return (
      <form autoComplete="off" onSubmit={this.onSubmit}>
        <TextField
          ref={element => this.messageField = element}
          id="your-message"
          name="your-message"
          floatingLabelText="Your message"
          fullWidth
          onChange={(e, message) => this.setState({ message })}
          value={this.state.message}
        />
      </form>
    );
  }
};

class Thread extends React.Component {
  constructor(props) {
    super(props);
    this.refetchData = this.refetchData.bind(this);
    this.createMessagesListRef = this.createMessagesListRef.bind(this);
    this.scrollMessagesList = this.scrollMessagesList.bind(this);
    this.messagesList = null;
  }

  createMessagesListRef(messagesList) {
    if (messagesList) {
      messagesList.scrollIntoView(true);
      messagesList.scrollTop = messagesList.scrollHeight;
      this.messagesList = messagesList;
    }
  }

  scrollMessagesList() {
    this.messagesList.scrollTop = this.messagesList.scrollHeight;
  }

  refetchData(slug) {
    this.props.relay.refetch(
      { slug },
      null,
      this.scrollMessagesList,
      { force: true }
    );
  }

  render() {
    const { data } = this.props;
    const { messages, id, slug } = data.thread;

    return (
      <Fragment>
        <Link to="/">Back to threads</Link>
        <h2>Your conversation</h2>
        <div className="messages" ref={this.createMessagesListRef}>
          {messages.map((message, key) => <Fragment key={`message-${key}`}><Message {...message} /></Fragment>)}
        </div>
        <MessageBox userId={data.user.id} threadId={id} onSendMessage={() => this.refetchData(slug)} />
      </Fragment>
    );
  }
}


const RefetchableThread = createRefetchContainer(
  Thread,
  graphql`
    fragment Thread on Query
    @argumentDefinitions(
      slug: { type: String }
      token: { type: String }
    ) {
      thread(slug: $slug) {
        id
        slug
        messages {
          content
        }
      }
      user(token: $token) {
        id
      }
    }
  `,
  graphql`
    query ThreadRefetchQuery(
      $slug: String!
      $token: String!
    ) {
      ...Thread
        @arguments(slug: $slug, token: $token)
    }
  `
);

const query = graphql`
  query ThreadQuery(
    $slug: String!
    $token: String!
  ) {
    ...Thread
      @arguments(slug: $slug, token: $token)
  }
`;

const ThreadRenderer = ({ match }) => {
  const token = window.localStorage.getItem('SessionToken');
  return (
    <QueryRenderer
      environment={modernEnvironment}
      query={query}
      variables={{slug: match.params.slug, token}}
      render={RelayRenderContainer(props => {
        return <RefetchableThread {...props} />;
      })}
    />
  );
};

export default ThreadRenderer;