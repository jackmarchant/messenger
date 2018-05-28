import React from 'react';
import { createFragmentContainer, graphql } from 'react-relay';
import { withRouter } from 'react-router-dom';
import { List, Subheader, ListItem, Avatar } from 'material-ui';
import CommunicationChatBubble from 'material-ui/svg-icons/communication/chat-bubble';

class ThreadList extends React.Component {
  render() {
    const { data, history } = this.props;

    if (!data.threads || data.threads.length === 0) {
      return null;
    }
  
    return (
      <List>
        <Subheader><h2>Recent messages</h2></Subheader>
        {
          data.threads.map(({slug, participants}, index) => {
            const first = participants[0];
  
            return (
              <ListItem
                key={`thread-${index}`}
                onClick={() => history.push(`/thread/${slug}`)}
                primaryText={`${first.firstname} ${first.lastname}`}
                leftAvatar={<Avatar src="https://loremflickr.com/100/100/people" />}
                rightIcon={<CommunicationChatBubble />}
              />
            );
          })
        }
      </List>
    );
  }
}

export { ThreadList };
export default createFragmentContainer(
  withRouter(ThreadList),
  graphql`
    fragment ThreadList on Query {
      threads {
        id
        slug
        participants {
          firstname
          lastname
        }
        messages {
          sender {
            id
            firstname
            lastname
          }
          content
        }
      }
    }
  `
);