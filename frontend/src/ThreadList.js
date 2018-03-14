import React from 'react';
import { createFragmentContainer, graphql } from 'react-relay';
import { withRouter } from 'react-router-dom';
import get from 'lodash.get';
import { List, Subheader, ListItem, Avatar } from 'material-ui';
import CommunicationChatBubble from 'material-ui/svg-icons/communication/chat-bubble';

const ThreadList = ({ data, history }) => {
  if (data.threads.length === 0) {
    return null
  }

  console.log(data);

  return (
    <List>
      <Subheader><h2>Recent messages</h2></Subheader>
      {
        data.threads.map(({id, participants}, index) => {
          const first = participants[0];

          return (
            <ListItem
              key={`thread-${index}`}
              onClick={() => history.push(`/thread/${id}`)}
              primaryText={`${first.firstname} ${first.lastname}`}
              leftAvatar={<Avatar src="https://loremflickr.com/100/100/people" />}
              rightIcon={<CommunicationChatBubble />}
            />
          );
        })
      }
    </List>
  );
};

export { ThreadList };
export default createFragmentContainer(
  withRouter(ThreadList),
  graphql`
    fragment ThreadList on Query {
      threads {
        id
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